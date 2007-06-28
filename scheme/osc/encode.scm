;; encode.scm - (c) rohan drape, 2002-2007

(module encode (lib "lang.ss" "r5rs")
(#%require "../ntp/ntp.scm"
	   "../u8/np.scm"
	   "../u8/u8l.scm"
	   (only "verify.scm"
		 bundle?
		 message?)
	   (only (lib "1.ss" "srfi")
		 make-list)
	   (only (lib "23.ss" "srfi")
		 error))
(#%provide (all-defined))

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

(define (exact-integer? n)
  (and (integer? n) (exact? n)))

(define (encode-value e)
  (cond ((exact-integer? e)   (i32 e))
	((real? e)            (f32 e))
	((string? e)          (encode-string e))
	((u8l? e)             (encode-bytes e))
	(else                 (error "encode-value: illegal value" e))))

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
		       (else               (error "encode-types: type?" e))))
	       l)))))

;; Encode OSC message.

(define (encode-message m)
  (list (encode-string (car m))
	(encode-types (cdr m))
	(map encode-value (cdr m))))

;; Encode OSC bundle. The first element is a <real> valued UTC
;; 'time-tag', each subsequent element must be an OSC 'message'.

(define (encode-bundle b)
  (list (encode-string "#bundle")
	(u64 (utc->ntp (car b)))
	(map (lambda (e)
	       (if (message? e)
		   (encode-bytes (osc->u8l e))
		   (error "encode-bundle: illegal value" e)))
	     (cdr b))))

;; An OSC packet is either an OSC message or an OSC bundle.

(define (osc->u8l p)
  (npt->u8l (if (bundle? p)
		(encode-bundle p)
		(encode-message p))))

)
