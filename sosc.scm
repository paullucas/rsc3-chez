
;; decode

;; OSC strings are C strings padded to a four byte boundary.

(define (read-ostr)
  (let* ((s (read-cstr))
	 (n (modulo (cstring-length s) 4))
	 (p (- 4 (modulo n 4))))
    (if (not (= n 0))
	(read-bstr p)
	#f)
    s))

;; OSC byte strings are length prefixed.

(define (read-obyt)
  (let* ((n (read-i32))
	 (b (read-bstr n))
	 (p (- 4 (modulo n 4))))
    (if (not (= n 0))
	(read-bstr p)
	#f)
    b))

;; Evaluates to the object, described by the OSC type character
;; `type', encoded at the OSC byte stream `p'.

(define (read-value t)
  (cond
   ((eq? t oI32) (read-i32))
   ((eq? t oI64) (read-i64))
   ((eq? t oU64) (read-u64))
   ((eq? t oF32) (read-f32))
   ((eq? t oF64) (read-f64))
   ((eq? t oStr) (read-ostr))
   ((eq? t oByt) (read-obyt))
   (else         (error 'read-value "bad type" t))))

;; Evaluate to the list of objects encoded at the OSC byte stream
;; `p', conforming to the types given in the OSC character type
;; list `types'.

(define (read-arguments types)
  (if (null? types)
      '()
      (cons (read-value (car types))
	    (read-arguments (cdr types)))))

;; Evaluate to the scheme representation of the OSC message at the OSC
;; byte stream `p'.  The first object is the 'address' of the
;; message, any subsequent objects are arguments for that address.

(define (read-message)
  (let* ((address (read-ostr))
	 (types (read-ostr)))
    (cons address
	  (read-arguments (cdr (string->list types))))))

;; Evaluate to a scheme representation of the OSC bundle encoded at
;; the OSC stream `p'.  The bundle ends at the end of the byte
;; stream.  The first object is the <real> UTC 'timetag' of the
;; bundle, any subsequent objects are either OSC messages or embedded
;; OSC bundles.

(define (read-bundle)
  (let ((bundletag (read-ostr))
	(timetag (ntp->utc. (read-u64)))
	(parts (list)))
    (if (not (equal? bundletag "#bundle"))
	(error 'read-bundle "illegal bundle tag" bundletag)
	(cons timetag
	      (let loop ((parts (list)))
		(if (eof-object? (lookahead-u8 (current-input-port)))
		    (reverse parts)
		    (begin
		      ;; We have no use for the message size...
		      (read-i32)
		      (loop (cons (read-packet) parts)))))))))

;; Evaluate to the scheme representation of the OSC packet encoded at
;; the OSC byte stream `p'. An OSC packet is either an OSC message
;; or an OSC bundle.

(define hash-u8 (char->integer #\#))

(define (read-packet)
  (if (eq? (lookahead-u8 (current-input-port)) hash-u8)
      (read-bundle)
      (read-message)))

(define (u8l->osc b)
  (with-input-from-u8l b read-packet))


;; display

;; Write a text representation of the OSC u8l `l'.  The format is that
;; used throughout the OSC specification.

(define (osc-display l)
  (for-each
   (lambda (b n)
     (display (format "~a (~a)" (number->string b 16) (integer->char b)))
     (if (= 3 (modulo n 4))
	 (newline)
	 (display #\space)))
   l
   (iota (length l))))


;; encode

(define (padding-of n) (make-list n (u8 0)))

;; OSC strings are C strings padded to a four byte boundary.

(define (cstring-length s)
  (+ 1 (string-length s)))

(define (encode-string s)
  (let ((n (modulo (cstring-length s) 4)))
    (list (cstr s)
	  (if (= n 0)
	      (list)
	      (padding-of (- 4 n))))))

;; OSC byte strings are length prefixed?

(define (encode-bytes b)
  (let* ((n (length b))
	 (n* (modulo n 4)))
    (list (i32 n)
	  (bstr b)
	  (if (= n* 0)
	      (list)
	      (padding-of (- 4 n*))))))

;; Allowable types are <integer>, <real>, <string>, or <u8l>.  Note
;; further that determining if a <real> should be written as a float
;; or a double is non-trivial and not undertaken here, all <real>s are
;; written as floats.

;; (define (exact-integer? n)
;;   (and (integer? n) (exact? n)))

(define (encode-value e)
  (cond ((exact-integer? e)   (i32 e))
	((real? e)            (f32 e))
	((string? e)          (encode-string e))
	((u8l? e)             (encode-bytes e))
	(else                 (error 'encode-value "illegal value" e))))

;; Encode the type string for the Evaluates to the OSC <u8l> indicating the types of the elements of
;; the list `l'.

(define (encode-types l)
  (encode-string
   (list->string
    (cons #\,
	  (map (lambda (e)
		 (cond ((exact-integer? e) #\i)
		       ((real? e)          #\f)
		       ((string? e)        #\s)
		       ((u8l? e)           #\b)
		       (else               (error 'encode-types "type?" e))))
	       l)))))

;; Encode OSC message.

(define (encode-message m)
  (list (encode-string (car m))
	(encode-types (cdr m))
	(map encode-value (cdr m))))

;; Encode OSC bundle. The first element is a <real> valued UTC
;; 'time-tag', each subsequent element must be an OSC 'message'.

(define (encode-bundle-ntp b)
  (list (encode-string "#bundle")
	(u64 (ntpr->ntp (car b)))
	(map (lambda (e)
	       (if (message? e)
		   (encode-bytes (osc->u8l e))
		   (error 'encode-bundle "illegal value" e)))
	     (cdr b))))

(define (encode-bundle b)
  (encode-bundle-ntp (cons (utc->ntpr (car b)) (cdr b))))

;; An OSC packet is either an OSC message or an OSC bundle.

(define (osc->u8l p)
  (npt->u8l (if (bundle? p)
		(encode-bundle p)
		(encode-message p))))


;; purify

;; Evaluates to a type-correct form of the OSC data `e'.  This
;; procedure does not verify that `e' is syntactically correct.
;; Boolean values are rewritten as integers, zero for '#f' and one for
;; '#t'.  Symbols are rewritten as the strings given by
;; 'symbol->string'.  An error is raised if `e' cannot be rewritten.
;; Note that R5RS does not require symbols to be case sensitive
;; although most interpreters will have an option to set this.

(define (purify e)
  (cond ((or (number? e) (string? e) (u8l? e)) e)
	((list? e) (map purify e))
	((symbol? e) (symbol->string e))
	((boolean? e) (if e 1 0))
	(else (error 'purify "illegal input" e))))


;; transport

;; 'u' is a <udp*>, 't' is a timeout in seconds.

(define (osc-send u m)
  (cond ((udp*? u)
	 (udp*-send u (osc->u8l m)))
	(else
	 (error 'osc-send "unknown transport"))))

(define (osc-recv u t)
  (cond ((udp*? u)
	 (let ((b (udp*-recv u t)))
	   (if b (u8l->osc b) #f)))
	(else
	 (error 'osc-recv "unknown transport"))))

(define (osc-request u r m t)
  (osc-send u m)
  (let ((p (osc-recv u t)))
    (if (and p (string=? (car p) r)) p #f)))


;; type

(define oI32 #\i)
(define oI64 #\h)
(define oU64 #\t)
(define oF32 #\f)
(define oF64 #\d)
(define oStr #\s)
(define oByt #\b)


;; verify

;; Validating constructors.

(define (message c . l)
  (if (string? c)
      (cons c l)
      (error 'message "illegal command" c)))

(define (bundle t . l)
  (if (number? t)
      (cons t l)
      (error 'bundle "illegal timestamp" t)))

;; Predicates for OSC packet types.

(define (message? p)
  (string? (car p)))

(define (bundle? p)
  (number? (car p)))

;; Evaluates to '#t' iff `m' is a correct OSC message.  The first
;; element must be a string 'address', subsequent elements are
;; arguments of types integer, real or string.

(define (verify-message m)
  (and (string? (car m))
       (not (find-tail (lambda (e) (not (or (integer? e)
					    (real? e)
					    (string? e))))
		       (cdr m)))))

;; Evaluates to '#t' iff `b' is a correct OSC bundle.  The first
;; element must be an integer 'timetag', subsequent elements may be OSC
;; messages or OSC bundles.  The timetags of embedded bundles must be
;; greater than or equal to the timetag of the containing bundle.

(define (verify-bundle b)
  (and (integer? (car b))
       (not (find-tail (lambda (e) (not (or (verify-message e)
					    (and (verify-bundle e)
						 (>= (car e) (car b))))))
		       (cdr b)))))

;; Evaluates to '#t' iff `p' is a correct OSC packet.  An OSC packet
;; is either an OSC message or an OSC bundle.

(define (verify-packet p)
  (or (verify-message p)
      (verify-bundle p)))
