
;; int

(define (byte n i)
  (fxand (fxarithmetic-shift-right i n) #xFF))

(define (int->u8l n size)
  (map (lambda (b)
	 (byte b n))
       (reverse (enum-from-then-to 0 8 (- size 8)))))

;; >=?

(define (sign n b)
  (let ((z (expt 2 b)))
    (if (> n (/ z 2))
	(- n z)
	n)))

(define (u8l->int l signed?)
  (let ((n (length l)))
    (let ((u (foldl + 0 (map fxarithmetic-shift-left
			     l
			     (reverse (enum-from-then-to 0 8 (* (- n 1) 8)))))))
      (if signed?
	  (sign u (* n 8))
	  u))))


;; np

;; Network protocol.

(define-structure np tag value)

;; Tags :: symbol

(define U8   'u8)
(define U16  'u16)
(define U32  'u32)
(define U64  'u64)
(define I16  'i16)
(define I32  'i32)
(define I64  'i64)
(define F32  'f32)
(define F64  'f64)
(define PSTR 'pstr)
(define CSTR 'cstr)
(define BSTR 'bstr)

;; Constructors :: ?value? -> np

(define (u8   n) (make-np U8   n))
(define (u16  n) (make-np U16  n))
(define (u32  n) (make-np U32  n))
(define (u64  n) (make-np U64  n))
(define (i16  n) (make-np I16  n))
(define (i32  n) (make-np I32  n))
(define (i64  n) (make-np I64  n))
(define (f32  n) (make-np F32  n))
(define (f64  n) (make-np F64  n))
(define (pstr s) (make-np PSTR s))
(define (cstr s) (make-np CSTR s))
(define (bstr s) (make-np BSTR s))

;; np->u8l :: np -> [u8]

(define (np->u8l e)
  (let ((t (np-tag e))
	(v (np-value e)))
    (case t
      ((u8)   (u8->u8l   v))
      ((u16)  (u16->u8l  v))
      ((u32)  (u32->u8l  v))
      ((u64)  (u64->u8l  v))
      ((i16)  (i16->u8l  v))
      ((i32)  (i32->u8l  v))
      ((i64)  (i64->u8l  v))
      ((f32)  (f32->u8l  v))
      ((f64)  (f64->u8l  v))
      ((pstr) (pstr->u8l v))
      ((cstr) (cstr->u8l v))
      ((bstr) v)
      (else   (error 'np->u8l "illegal value" t v)))))

;; u8l->np :: tag -> [u8] -> np

(define (u8l->np tag l)
  (case tag
      ((u8)   (u8l->u8   l))
      ((u16)  (u8l->u16  l))
      ((u32)  (u8l->u32  l))
      ((u64)  (u8l->u64  l))
      ((i16)  (u8l->i16  l))
      ((i32)  (u8l->i32  l))
      ((i64)  (u8l->i64  l))
      ((f32)  (u8l->f32  l))
      ((f64)  (u8l->f64  l))
      ((pstr) (u8l->pstr l))
      ((cstr) (u8l->cstr l))
      (else   (error 'u8l->np "illegal tag" tag l))))

;; read-np :: tag -> IO ?value?

(define (read-np tag)
  (case tag
    ((u8)   (get-u8))
    ((u16)  (u8l->u16 (read-u8l 2)))
    ((u32)  (u8l->u32 (read-u8l 4)))
    ((u64)  (u8l->u64 (read-u8l 6)))
    ((i16)  (u8l->i16 (read-u8l 2)))
    ((i32)  (u8l->i32 (read-u8l 4)))
    ((i64)  (u8l->i64 (read-u8l 8)))
    ((f32)  (u8l->f32 (read-u8l 4)))
    ((f64)  (u8l->f64 (read-u8l 8)))
    ((pstr) (read-pstr))
    ((cstr) (read-cstr))
    (else   (error 'read-np "illegal tag" tag))))

;; write-np :: np -> IO ()

(define (write-np np)
  (map put-u8 (np->u8l np)))

;; npt->u8l :: [npt] -> [int]

(define (npt->u8l t)
  (flatten (mapt np->u8l t)))


;; u8l

(define (real->u8l x size)
  (let* ((n (/ size 8))
	 (v (make-bytevector n 0)))
    (if (= n 4)
	(bytevector-ieee-single-set! v 0 x (endianness 'big))
	(bytevector-ieee-double-set! v 0 x (endianness 'big)))
    (bytevector->u8-list v)))

(define (u8l->real l)
  (let ((v (u8-list->bytevector l)))
    (if (= (bytevector-length v) 4)
	(bytevector-ieee-single-ref v (endianness 'big))
	(bytevector-ieee-double-ref v (endianness 'big)))))

(define (with-input-from-u8l l f)
  (parameterize
   ((current-input-port (open-bytevector-input-port (u8-list->bytevector l))))
   (f)))

(define (with-output-to-u8l f)
  (let ((f* (lambda (p)
	      (parameterize
	       ((current-output-port p))
	       (f)))))
    (bytevector->u8-list (call-with-bytevector-output-port f*))))

;; u8l? :: [u8] -> true

(define (u8l? l)
  (and (list? l)
       (all u8? l)))

;; Decoders

(define (u8l->u8  l) (list-ref l 0))
(define (u8l->u16 l) (u8l->int l #f))
(define (u8l->u32 l) (u8l->int l #f))
(define (u8l->u64 l) (u8l->int l #f))
(define (u8l->i8  l) (u8->i8 (u8l->u8 l)))
(define (u8l->i16 l) (u8l->int l #t))
(define (u8l->i32 l) (u8l->int l #t))
(define (u8l->i64 l) (u8l->int l #t))
(define (u8l->f32 l) (u8l->real l))
(define (u8l->f64 l) (u8l->real l))

;; Encoders

(define (u8->u8l  n) (list n))
(define (u16->u8l n) (int->u8l n 16))
(define (u32->u8l n) (int->u8l n 32))
(define (u64->u8l n) (int->u8l n 64))
(define (i8->u8l  n) (u8->u8l (i8->u8 n)))
(define (i16->u8l n) (int->u8l n 16))
(define (i32->u8l n) (int->u8l n 32))
(define (i64->u8l n) (int->u8l n 64))
(define (f32->u8l n) (real->u8l n 32))
(define (f64->u8l n) (real->u8l n 64))

;; String coding

(define (u8l->str l n)
  (list->string (map integer->char (take n l))))

(define (u8l->pstr l)
  (let ((n (car l))
	(l* (cdr l)))
    (u8l->str l* n)))

(define (u8l->cstr l)
  (let ((n (find-index (lambda (b) (= b 0)) l)))
    (u8l->str l n)))

(define (str->u8l s)
  (map char->integer (string->list s)))

(define (pstr->u8l s)
  (cons (string-length s) (str->u8l s)))

(define (cstr->u8l s)
  (append (str->u8l s) (list 0)))

;; read-u8l :: int -> IO [u8]

(define (read-u8l n)
  (map1 (lambda (_) 
	  (get-u8 (current-input-port))) 
	(enum-from-to 1 n)))

(define (write-u8l l)
  (for-each (lambda (e) (put-u8 e (current-output-port))) l))

;; read-pstr :: IO str

(define (read-pstr)
  (u8l->str (read-u8l (get-u8 (current-input-port)))))

;; read-cstr :: IO str

(define (read-cstr)
  (let loop ((l (list))
	     (b (get-u8 (current-input-port))))
    (if (= b 0)
	(u8l->str (reverse l) (length l))
	(loop (cons b l) (get-u8 (current-input-port))))))

;; read-bstr :: IO [u8]

(define read-bstr read-u8l)

;; Readers :: IO ?value?

(define (read-i16)  (u8l->i16 (read-u8l 2)))
(define (read-u16)  (u8l->u16 (read-u8l 2)))
(define (read-i32)  (u8l->i32 (read-u8l 4)))
(define (read-u32)  (u8l->u32 (read-u8l 4)))
(define (read-i64)  (u8l->i64 (read-u8l 8)))
(define (read-u64)  (u8l->u64 (read-u8l 8)))
(define (read-f32)  (u8l->f32 (read-u8l 4)))
(define (read-f64)  (u8l->f64 (read-u8l 8)))

;; tag->reader :: sym -> IO ?value?

(define (tag->reader t)
  (case t
    ((u8)   (lambda () (get-u8 (current-input-port))))
    ((u16)  read-u16)
    ((i16)  read-i16)
    ((u32)  read-u32)
    ((i32)  read-i32)
    ((u64)  read-u64)
    ((i64)  read-i64)
    ((f32)  read-f32)
    ((f64)  read-f64)
    ((pstr) read-pstr)
    ((cstr) read-cstr)))

;; file->u8l :: string -> [u8]

(define (file->u8l f)
  (with-input-from-file f
    (lambda ()
      (let loop ((l (list)))
	(if (eof-object? (lookahead-u8 (current-input-port)))
	    (reverse l)
	    (loop (cons (get-u8 (current-input-port)) l)))))))


;; u8

(define (u8? b)
  (and (integer? b)
       (>= b 0)
       (< b 256)))

(define (u8->i8 n)
  (if (> n 127)
      (- n 256)
      n))

(define (i8->u8 n)
  (if (< n 0)
      (+ n 256)
      n))


;; u8v

#|
(define (u8v? v)
  (and (vector? v)
       (vector-every u8? v)))

(define u8l->u8v list->vector)
(define u8v->u8l vector->list)

(define (u8->u8v  n)   (vector n))
(define (u16->u8v n)   (u8l->u8v (u16->u8l n)))
(define (u32->u8v n)   (u8l->u8v (u32->u8l n)))
(define (u64->u8v n)   (u8l->u8v (u64->u8l n)))
(define (i8->u8v  n)   (u8->u8v (i8->u8 n)))
(define (i16->u8v n)   (u8l->u8v (i16->u8l n)))
(define (i32->u8v n)   (u8l->u8v (i32->u8l n)))
(define (i64->u8v n)   (u8l->u8v (i64->u8l n)))
(define (f32->u8v n)   (u8l->u8v (f32->u8l n)))
(define (f64->u8v n)   (u8l->u8v (f64->u8l n)))
(define (str->u8v s)   (u8l->u8v (str->u8l s)))

(define (u8v->u8 v)    (vector-ref v 0))
(define (u8v->u16 v)   (u8l->u16 (u8v->u8l v)))
(define (u8v->u32 v)   (u8l->u32 (u8v->u8l v)))
(define (u8v->u64 v)   (u8l->u64 (u8v->u8l v)))
(define (u8v->i8 v)    (u8->i8 (u8v->u8 v)))
(define (u8v->i16 v)   (u8l->i16 (u8v->u8l v)))
(define (u8v->i32 v)   (u8l->i32 (u8v->u8l v)))
(define (u8v->i64 v)   (u8l->i64 (u8v->u8l v)))
(define (u8v->f32 v)   (u8l->f32 (u8v->u8l v)))
(define (u8v->f64 v)   (u8l->f64 (u8v->u8l v)))
(define (u8v->str v n) (u8l->str (u8v->u8l v) n))

(define (file->u8v f)
  (u8l->u8v (file->u8l f)))
|#


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

(define 2^32 (expt 2 32))
(define 2^32. (exact->inexact 2^32))

(define seconds-from-1900-to-1970 (+ (* 70 365 24 60 60) (* 17 24 60 60)))
(define (ntpr->ntp i)             (round-exact (* i 2^32)))
(define (ntp-to-seconds i)        (/ i 2^32))
(define (ntp-to-seconds. i)       (/ i 2^32.))
(define (nanoseconds-to-ntp i)    (round-exact (* i (/ 2^32 (expt 10 9)))))
(define (ntp-to-nanoseconds i)    (* i (/ (expt 10 9) 2^32)))

;; Convert between time intervals in seconds and NTP intervals.

(define (time-interval->ntp-interval interval)
  (ntpr->ntp interval))

(define (ntp-interval->time-interval ntp-interval)
  (ntp-to-seconds ntp-interval))

(define (ntp-interval->time-interval. ntp-interval)
  (ntp-to-seconds. ntp-interval))

;; Evaluate to an <real> representing the NTP time of the UTC time of
;; the <real> number `n'.

(define (utc->ntpr n)
  (+ n seconds-from-1900-to-1970))

;; Evaluate to an <integer> representing the NTP time of the UTC time
;; of the <real> number `n'.

(define (utc->ntp n)
  (ntpr->ntp (+ n seconds-from-1900-to-1970)))

;; Evaluate to a <real> number representing the UTC time of the
;; <integer> NTP time `ntp'.

(define (ntp->utc ntp)
  (- (ntp-to-seconds ntp) seconds-from-1900-to-1970))

(define (ntp->utc. ntp)
  (- (ntp-to-seconds. ntp) seconds-from-1900-to-1970))

;; Evaluate to an integer representing the NTP time of the SRFI-19
;; time object `time', which must be in UTC format.

;(define (utc-time->ntp time)
;  (let ((seconds (time-second time))
;	(nanoseconds (time-nanosecond time)))
;    (fxior (fxarithmetic-shift-left (+ seconds seconds-from-1900-to-1970)
;				    32)
;	   (nanoseconds-to-ntp nanoseconds))))

;; Evaluate to an SRFI-19 time object representing UTC time of the NTP
;; time `ntp'.

;(define (ntp->utc-time ntp)
;  (let ((seconds (- (fxarithmetic-shift-right ntp 32) seconds-from-1900-to-1970))
;	(nanoseconds (ntp-to-nanoseconds (fxand ntp #xFFFFFFFF))))
;    (make-time time-utc nanoseconds seconds)))


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
   (enum-from-to 0 (- (length l) 1))))


;; encode

(define (padding-of n) (replicate n (u8 0)))

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

(define (message c l)
  (if (string? c)
      (cons c l)
      (error "message: illegal address")))

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
       (all (lambda (e) (or (integer? e)
			    (real? e)
			    (string? e)))
	    (cdr m))))

;; Evaluates to '#t' iff `b' is a correct OSC bundle.  The first
;; element must be an integer 'timetag', subsequent elements may be OSC
;; messages or OSC bundles.  The timetags of embedded bundles must be
;; greater than or equal to the timetag of the containing bundle.

(define (verify-bundle b)
  (and (integer? (car b))
       (all (lambda (e) (or (verify-message e)
			    (and (verify-bundle e)
				 (>= (car e) (car b)))))
	    (cdr b))))

;; Evaluates to '#t' iff `p' is a correct OSC packet.  An OSC packet
;; is either an OSC message or an OSC bundle.

(define (verify-packet p)
  (or (verify-message p)
      (verify-bundle p)))

