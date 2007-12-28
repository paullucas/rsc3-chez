;; decode.scm - (c) rohan drape, 2002-2007

(module decode scheme/base

(require (only-in "../mzscheme/r6rs.ss"
		  lookahead-u8)
	 "../ntp/ntp.scm"
	 (only-in "../u8/u8l.scm"
		  read-i32
		  read-i64
		  read-u64
		  read-f32
		  read-f64
		  read-bstr
		  read-cstr
		  with-input-from-u8l)
	 (only-in "encode.scm"
		  cstring-length)
	 "type.scm")

(provide u8l->osc)

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

)
