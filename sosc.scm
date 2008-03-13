;; bytevector -> int -> int -> bytevector
(define bytevector-section
  (lambda (v l r)
    (let* ((n (- r l))
	   (w (r6rs:make-bytevector n 0)))
      (r6rs:bytevector-copy! v l w 0 n)
      w)))

;; bytevector -> byte -> int
(define bytevector-find-index
  (lambda (v x)
    (letrec ((f (lambda (i)
		  (if (= (r6rs:bytevector-u8-ref v i) x)
		      i
		      (f (+ i 1))))))
      (f 0))))

;; [bytevector] -> bytevector
(define flatten-bytevectors
  (lambda (t)
    (let* ((l (flatten t))
	   (n (map1 r6rs:bytevector-length l))
	   (m (sum n))
	   (v (r6rs:make-bytevector m)))
      (let loop ((i 0)
		 (l l)
		 (n n))
	(if (null? l)
	    v
	    (let ((l0 (car l))
		  (n0 (car n)))
	      (r6rs:bytevector-copy! l0 0 v i n0)
	      (loop (+ i n0) (cdr l) (cdr n))))))))

;; (bytevector -> int -> x) -> int -> x
(define bytevector-make-and-set1
  (lambda (f k n)
    (let ((v (r6rs:make-bytevector k 0)))
      (f v 0 n)
      v)))

;; (bytevector -> int -> x) -> int -> x
(define bytevector-make-and-set
  (lambda (f k n)
    (let ((v (r6rs:make-bytevector k 0)))
      (f v 0 n be)
      v)))

(define decode-u8
  (lambda (v) 
    (r6rs:bytevector-u8-ref v 0)))

(define decode-u16
  (lambda (v) 
    (r6rs:bytevector-u16-ref v 0 be)))

(define decode-u32
  (lambda (v) 
    (r6rs:bytevector-u32-ref v 0 be)))

(define decode-u64
  (lambda (v) 
    (r6rs:bytevector-u64-ref v 0 be)))

(define decode-i8
  (lambda (v) 
    (r6rs:bytevector-s8-ref v 0)))

(define decode-i16
  (lambda (v) 
    (r6rs:bytevector-s16-ref v 0 be)))

(define decode-i32
  (lambda (v)
    (r6rs:bytevector-s32-ref v 0 be)))

(define decode-i64
  (lambda (v)
    (r6rs:bytevector-s64-ref v 0 be)))

(define decode-f32
  (lambda (v) 
    (r6rs:bytevector-ieee-single-ref v 0)))

(define decode-f64
  (lambda (v) 
    (r6rs:bytevector-ieee-double-ref v 0)))

(define decode-str
  (lambda (b)
    (r6rs:utf8->string b)))

(define decode-pstr
  (lambda (v)
    (let* ((n (decode-u8 v))
	   (w (bytevector-section v 1 (+ n 1))))
      (decode-str w))))

(define decode-cstr
  (lambda (v)
    (let* ((n (bytevector-find-index v 0))
	   (w (bytevector-section v 0 n)))
      (decode-str w))))

(define be (r6rs:endianness big))

(define encode-u8
  (lambda (n)  
    (bytevector-make-and-set1 r6rs:bytevector-u8-set! 1 n)))

(define encode-u16
  (lambda (n)
    (bytevector-make-and-set r6rs:bytevector-u16-set! 2 n)))

(define encode-u32
  (lambda (n)
    (bytevector-make-and-set r6rs:bytevector-u32-set! 4 n)))

(define encode-u64
  (lambda (n)
    (bytevector-make-and-set r6rs:bytevector-u64-set! 8 n)))

(define encode-i8
  (lambda (n) 
    (bytevector-make-and-set1 r6rs:bytevector-s8-set! 1 n)))

(define encode-i16
  (lambda (n)
    (bytevector-make-and-set r6rs:bytevector-s16-set! 2 n)))

(define encode-i32
  (lambda (n) 
    (bytevector-make-and-set r6rs:bytevector-s32-set! 4 n)))

(define encode-i64
  (lambda (n)
    (bytevector-make-and-set r6rs:bytevector-s64-set! 8 n)))

(define encode-f32
  (lambda (n)
    (bytevector-make-and-set r6rs:bytevector-ieee-single-set! 4 n)))

(define encode-f64
  (lambda (n)
    (bytevector-make-and-set r6rs:bytevector-ieee-double-set! 8 n)))

(define encode-str
  (lambda (s)
    (r6rs:string->utf8 s)))

(define encode-pstr
  (lambda (s)
    (let* ((b (encode-str s))
	   (n (encode-u8 (r6rs:bytevector-length b))))
      (list n b))))

(define encode-cstr
  (lambda (s)
    (let* ((b (encode-str s))
	   (z (encode-u8 0)))
      (list b z))))

(define read-pstr
  (lambda ()
    (let* ((p (current-input-port))
	   (n (r6rs:lookahead-u8 p))
	   (v (read-bstr (+ n 1))))
      (decode-pstr v))))

(define read-cstr
  (lambda ()
    (let loop ((l nil)
	       (b (r6rs:get-u8 (current-input-port))))
      (if (= b 0)
	  (list->string (map integer->char (reverse l)))
	  (loop (cons b l) (r6rs:get-u8 (current-input-port)))))))

;; int -> bytevector
(define read-bstr
  (lambda (n)
    (r6rs:get-bytevector-n (current-input-port) n)))

(define read-i16
  (lambda () 
    (decode-i16 (read-bstr 2))))

(define read-u16
  (lambda () 
    (decode-u16 (read-bstr 2))))

(define read-i32 
  (lambda () 
    (decode-i32 (read-bstr 4))))

(define read-u32 
  (lambda () 
    (decode-u32 (read-bstr 4))))

(define read-i64 
  (lambda () 
    (decode-i64 (read-bstr 8))))

(define read-u64 
  (lambda () 
    (decode-u64 (read-bstr 8))))

(define read-f32 
  (lambda () 
    (decode-f32 (read-bstr 4))))

(define read-f64 
  (lambda () 
    (decode-f64 (read-bstr 8))))


;; ntp

;; NTP is the Network Time Protocol.  NTP time is represented by a 64
;; bit fixed point number. The first 32 bits specify the number of
;; seconds since midnight on January 1, 1900, and the last 32 bits
;; specify fractional parts of a second to a precision of about 200
;; picoseconds. This is the representation used by Internet NTP
;; timestamps.

;; The number of seconds from the start of 1900 to the start of 1970.
;; NTP is measured from the former, UTC from the latter.  There are 17
;; leap years in this period.

(define 2^32
  (expt 2 32))

(define 2^32.
  (exact->inexact 2^32))

(define seconds-from-1900-to-1970
  (+ (* 70 365 24 60 60) (* 17 24 60 60)))

(define ntpr->ntp
  (lambda (i)
    (round-exact (* i 2^32))))

(define ntp-to-seconds
  (lambda (i)
    (/ i 2^32)))

(define ntp-to-seconds. 
  (lambda (i)
    (/ i 2^32.)))

(define nanoseconds-to-ntp
  (lambda (i)
    (round-exact (* i (/ 2^32 (expt 10 9))))))

(define ntp-to-nanoseconds
  (lambda (i)
    (* i (/ (expt 10 9) 2^32))))

;; Convert between time intervals in seconds and NTP intervals.

(define time-interval->ntp-interval
  (lambda (interval)
    (ntpr->ntp interval)))

(define ntp-interval->time-interval
  (lambda (ntp-interval)
    (ntp-to-seconds ntp-interval)))

(define ntp-interval->time-interval. 
  (lambda (ntp-interval)
    (ntp-to-seconds. ntp-interval)))

;; Evaluate to an <real> representing the NTP time of the UTC time of
;; the <real> number `n'.

(define utc->ntpr
  (lambda (n)
    (+ n seconds-from-1900-to-1970)))

;; Evaluate to an <integer> representing the NTP time of the UTC time
;; of the <real> number `n'.

(define utc->ntp
  (lambda (n)
    (ntpr->ntp (+ n seconds-from-1900-to-1970))))

;; Evaluate to a <real> number representing the UTC time of the
;; <integer> NTP time `ntp'.

(define ntp->utc
  (lambda (ntp)
    (- (ntp-to-seconds ntp) seconds-from-1900-to-1970)))

(define ntp->utc. 
  (lambda (ntp)
    (- (ntp-to-seconds. ntp) seconds-from-1900-to-1970)))

;; Evaluate to an integer representing the NTP time of the SRFI-19
;; time object `time', which must be in UTC format.

					;(define utc-time->ntp
					; (lambda (time)
					;  (let ((seconds (time-second time))
					;	(nanoseconds (time-nanosecond time)))
					;    (fxior (fxarithmetic-shift-left (+ seconds seconds-from-1900-to-1970)
					;				    32)
					;	   (nanoseconds-to-ntp nanoseconds)))))

;; Evaluate to an SRFI-19 time object representing UTC time of the NTP
;; time `ntp'.

					;(define ntp->utc-time
					; (lambda (ntp)
					;  (let ((seconds (- (fxarithmetic-shift-right ntp 32) seconds-from-1900-to-1970))
					;	(nanoseconds (ntp-to-nanoseconds (fxand ntp #xFFFFFFFF))))
					;    (make-time time-utc nanoseconds seconds))))


;; decode

;; OSC strings are C strings padded to a four byte boundary.

(define read-ostr
  (lambda ()
    (let* ((s (read-cstr))
	   (n (modulo (cstring-length s) 4))
	   (p (- 4 (modulo n 4))))
      (if (not (= n 0))
	  (read-bstr p)
	  #f)
      s)))

;; OSC byte strings are length prefixed.

(define read-obyt
  (lambda ()
    (let* ((n (read-i32))
	   (b (read-bstr n))
	   (p (- 4 (modulo n 4))))
      (if (not (= n 0))
	  (read-bstr p)
	  #f)
      b)))

;; Evaluates to the object, described by the OSC type character
;; `type', encoded at the OSC byte stream `p'.

(define read-value
  (lambda (t)
    (cond
     ((eq? t oI32) (read-i32))
     ((eq? t oI64) (read-i64))
     ((eq? t oU64) (read-u64))
     ((eq? t oF32) (read-f32))
     ((eq? t oF64) (read-f64))
     ((eq? t oStr) (read-ostr))
     ((eq? t oByt) (read-obyt))
     (else         (error 'read-value "bad type" t)))))

;; Evaluate to the list of objects encoded at the OSC byte stream
;; `p', conforming to the types given in the OSC character type
;; list `types'.

(define read-arguments
  (lambda (types)
    (if (null? types)
	'()
	(cons (read-value (car types))
	      (read-arguments (cdr types))))))

;; Evaluate to the scheme representation of the OSC message at the OSC
;; byte stream `p'.  The first object is the 'address' of the
;; message, any subsequent objects are arguments for that address.

(define read-message
  (lambda ()
    (let* ((address (read-ostr))
	   (types (read-ostr)))
      (cons address
	    (read-arguments (cdr (string->list types)))))))

;; Evaluate to a scheme representation of the OSC bundle encoded at
;; the OSC stream `p'.  The bundle ends at the end of the byte
;; stream.  The first object is the <real> UTC 'timetag' of the
;; bundle, any subsequent objects are either OSC messages or embedded
;; OSC bundles.

(define read-bundle
  (lambda ()
    (let ((bundletag (read-ostr))
	  (timetag (ntp->utc. (read-u64)))
	  (parts (list)))
      (if (not (equal? bundletag "#bundle"))
	  (error 'read-bundle "illegal bundle tag" bundletag)
	  (cons timetag
		(let loop ((parts (list)))
		  (if (eof-object? (r6rs:lookahead-u8 (current-input-port)))
		      (reverse parts)
		      (begin
			;; We have no use for the message size...
			(read-i32)
			(loop (cons (read-packet) parts))))))))))

;; Evaluate to the scheme representation of the OSC packet encoded at
;; the OSC byte stream `p'. An OSC packet is either an OSC message
;; or an OSC bundle.

(define hash-u8
  (char->integer #\#))

(define read-packet
  (lambda ()  
    (if (eq? (r6rs:lookahead-u8 (current-input-port)) hash-u8)
	(read-bundle)
	(read-message))))

(define with-input-from-bytevector 
  (lambda (b f)
    (parameterize
     ((current-input-port (r6rs:open-bytevector-input-port b)))
     (f))))

(define decode-osc
  (lambda (b)
    (with-input-from-bytevector b read-packet)))



;; [Word8] -> IO ()
(define osc-display
  (lambda (l)
    (for-each
     (lambda (b n)
       (display (format "~a (~a)" (number->string b 16) (integer->char b)))
       (if (= 3 (modulo n 4))
	   (newline)
	   (display #\space)))
     l
     (enum-from-to 0 (- (length l) 1)))))


;; encode

(define padding-of
  (lambda (n) (replicate n (encode-u8 0))))

;; OSC strings are C strings padded to a four byte boundary.

(define cstring-length
  (lambda (s)
    (+ 1 (string-length s))))

(define encode-string
  (lambda (s)
    (let ((n (modulo (cstring-length s) 4)))
      (list (encode-cstr s)
	    (if (= n 0)
		(list)
		(padding-of (- 4 n)))))))

;; OSC byte strings are length prefixed?

(define encode-bytes
  (lambda (b)
    (let* ((n (r6rs:bytevector-length b))
	   (n* (modulo n 4)))
      (list (encode-i32 n)
	    b
	    (if (= n* 0)
		(list)
		(padding-of (- 4 n*)))))))

;; Allowable types are <integer>, <real>, <string>, or <bytevector>.  Note
;; further that determining if a <real> should be written as a float
;; or a double is non-trivial and not undertaken here, all <real>s are
;; written as floats.

;; (define exact-integer?
;; (lambda (n)
;;   (and (integer? n) (exact? n))))

(define encode-value
  (lambda (e)
    (cond ((exact-integer? e)   (encode-i32 e))
	  ((real? e)            (encode-f32 e))
	  ((string? e)          (encode-string e))
	  ((r6rs:bytevector? e)      (encode-bytes e))
	  (else                 (error 'encode-value "illegal value" e)))))

(define encode-types
  (lambda (l)
    (encode-string
     (list->string
      (cons #\,
	    (map (lambda (e)
		   (cond ((exact-integer? e) #\i)
			 ((real? e)          #\f)
			 ((string? e)        #\s)
			 ((r6rs:bytevector? e)           #\b)
			 (else               (error 'encode-types "type?" e))))
		 l))))))

;; Encode OSC message.

(define encode-message
  (lambda (m)
    (list (encode-string (car m))
	  (encode-types (cdr m))
	  (map encode-value (cdr m)))))

;; Encode OSC bundle. The first element is a <real> valued UTC
;; 'time-tag', each subsequent element must be an OSC 'message'.

(define encode-bundle-ntp
  (lambda (b)
    (list (encode-string "#bundle")
	  (encode-u64 (ntpr->ntp (car b)))
	  (map (lambda (e)
		 (if (message? e)
		     (encode-bytes (encode-osc e))
		     (error 'encode-bundle "illegal value" e)))
	       (cdr b)))))

(define encode-bundle
  (lambda (b)
    (encode-bundle-ntp (cons (utc->ntpr (car b)) (cdr b)))))

;; An OSC packet is either an OSC message or an OSC bundle.

(define encode-osc
  (lambda (p)
    (flatten-bytevectors
     (if (bundle? p)
	 (encode-bundle p)
	 (encode-message p)))))


;; purify

;; Evaluates to a type-correct form of the OSC data `e'.  This
;; procedure does not verify that `e' is syntactically correct.
;; Boolean values are rewritten as integers, zero for '#f' and one for
;; '#t'.  Symbols are rewritten as the strings given by
;; 'symbol->string'.  An error is raised if `e' cannot be rewritten.
;; Note that R5RS does not require symbols to be case sensitive
;; although most interpreters will have an option to set this.

(define purify
  (lambda (e)
    (cond ((or (number? e) (string? e) (r6rs:bytevector? e)) e)
	  ((list? e) (map purify e))
	  ((symbol? e) (symbol->string e))
	  ((boolean? e) (if e 1 0))
	  (else (error 'purify "illegal input" e)))))


;; transport

;; port -> osc -> ()
(define send
  (lambda (u m)
    (cond ((udp*? u)
	   (udp*-send u (encode-osc m)))
	  (else
	   (error "send: unknown transport")))))

;; port -> float -> osc
(define recv
  (lambda (u t)
    (cond ((udp*? u)
	   (let ((b (udp*-recv u t)))
	     (if b (decode-osc b) #f)))
	  (else
	   (error "recv: unknown transport")))))

(define osc-request
  (lambda (u r m t)
    (send u m)
    (let ((p (recv u t)))
      (if (and p (string=? (car p) r)) p #f))))


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

(define message
  (lambda (c l)
    (if (string? c)
	(cons c l)
	(error "message: illegal address"))))

(define bundle
  (lambda (t l)
    (if (number? t)
	(cons t l)
	(error "bundle: illegal timestamp" t))))

;; Predicates for OSC packet types.

(define message?
  (lambda (p)
    (string? (car p))))

(define bundle?
  (lambda (p)
    (number? (car p))))

;; Evaluates to '#t' iff `m' is a correct OSC message.  The first
;; element must be a string 'address', subsequent elements are
;; arguments of types integer, real or string.

(define verify-message
  (lambda (m)
    (and (string? (car m))
	 (all (lambda (e) (or (integer? e)
			      (real? e)
			      (string? e)))
	      (cdr m)))))

;; Evaluates to '#t' iff `b' is a correct OSC bundle.  The first
;; element must be an integer 'timetag', subsequent elements may be OSC
;; messages or OSC bundles.  The timetags of embedded bundles must be
;; greater than or equal to the timetag of the containing bundle.

(define verify-bundle
  (lambda (b)
    (and (integer? (car b))
	 (all (lambda (e) (or (verify-message e)
			      (and (verify-bundle e)
				   (>= (car e) (car b)))))
	      (cdr b)))))

;; Evaluates to '#t' iff `p' is a correct OSC packet.  An OSC packet
;; is either an OSC message or an OSC bundle.

(define verify-packet
  (lambda (p)
    (or (verify-message p)
	(verify-bundle p))))
