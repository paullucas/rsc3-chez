;; encode.scm - (c) rohan drape, 2002-2006

;; Evaluates to the OSC <u8v> representing the <string> `s'.
;; OSC strings are zero terminated, and end at a four byte boundary.

(define (encode-string s)
  (u8v-++ (string->u8v s)
	  (make-u8v (- 4 (modulo (string-length s) 4)) 0)))

;; Evaluates to the OSC <u8v> representing the <u8v>
;; `b'.  OSC <u8v>s are length prefixed with a four byte signed
;; network order integer, and zero byte padded to a four byte
;; boundary.

(define (encode-bytes b)
  (let ((n (u8v-length b)))
    (u8v-concat (list (i32->u8v n)
		      b
		      (make-u8v (- 4 (modulo n 4)) 0)))))

;; Evaluates to the OSC <u8v> representing the object `e'.
;; The value `e' must be of type <integer>, <real>, <string>, or
;; <u8v>.  Note further that determining if a <real> should be
;; written as a float or a double is non-trivial and not undertaken
;; here, all <real>s are written as floats.

(define (exact-integer? n)
  (and (integer? n) (exact? n)))

(define (encode-value e)
  (cond ((exact-integer? e)   (i32->u8v e))
	((real? e)            (f32->u8v e))
	((string? e)          (encode-string e))
	((u8v? e)             (encode-bytes e))
	(else                 (error "encode-value: illegal value" e))))

;; Evaluates to the OSC <u8v> indicating the types of the
;; elements of the list `l'.

(define (encode-types l)
  (encode-string
   (list->string
    (cons #\,
	  (map (lambda (e)
		 (cond ((exact-integer? e) #\i)
		       ((real? e)          #\f)
		       ((string? e)        #\s)
		       ((u8v? e)           #\b)
		       (else               (error "encode-types: type?" e))))
	       l)))))

;; Evaluates to the OSC <u8v> encoding the scheme OSC message
;; `message'.  A scheme OSC message is a <list>, the first element is
;; an address <string>, subsequent elements are <integer>, <real>,
;; <string> and <u8v> arguments.

(define (encode-message m)
  (u8v-concat (list (encode-string (car m))
		    (encode-types (cdr m))
		    (u8v-concat (map encode-value (cdr m))))))

;; Evaluates to the OSC <u8v> encoding the scheme OSC bundle
;; `bundle'.  A scheme OSC bundle is a <list>, the first element is a
;; <real> valued UTC 'time-tag', each subsequent element must be an
;; OSC 'message'.

(define (encode-bundle* t m)
 (u8v-concat (list (encode-string "#bundle")
		   (u64->u8v (utc->ntp t))
		   (u8v-concat
		    (map (lambda (m)
			   (u8v-append (i32->u8v (u8v-length m)) m))
			 m)))))

(define (encode-bundle b)
  (encode-bundle*
   (car b)
   (map (lambda (e)
	  (if (message? e)
	      (encode-message e)
	      (error "encode-bundle: illegal value" e)))
	(cdr b))))

;; Evaluates to the OSC <u8v> encoding the scheme OSC packet
;; `packet'.  A scheme OSC packet is either a scheme OSC message or a
;; scheme OSC bundle.

(define (encode-packet p)
  (if (bundle? p)
      (encode-bundle p)
      (encode-message p)))

(define (osc->u8v b) (encode-packet b))
