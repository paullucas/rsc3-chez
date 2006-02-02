;; u8v.scm - (c) rohan drape, 2001-2006

;; PLT provides two incompatible types for byte vectors, <bytes> and
;; <u8vector>.  This aliases <u8v> to <bytes>.

(define u8v?             bytes?)
(define make-u8v         make-bytes)
(define u8v              bytes)
(define u8v=?            bytes=?)
(define u8v-copy         bytes-copy)
(define u8v-copy*        subbytes)
(define u8v-copy!        bytes-copy!)
(define u8v-set!         bytes-set!)
(define u8v-ref          bytes-ref)
(define u8v-length       bytes-length)
(define u8v-append       bytes-append)
(define (u8v-++ a b)     (u8v-append a b))
(define read-u8v!        read-bytes)
(define write-u8v!       write-bytes)
(define open-input-u8v!  open-input-bytes)
(define open-output-u8v! open-output-bytes)
(define get-output-u8v!  get-output-bytes)
(define u8v->list        bytes->list)
(define list->u8v        list->bytes)
(define u8v->string      bytes->string/utf-8)
(define string->u8v      string->bytes/utf-8)

(define (u8v-concat l)  (fold-right u8v-++ (u8v) l))

(define read-byte!      read-byte)
(define peek-byte!      peek-byte)

;; Must provide procedures for converting to and from binary integer
;; types and IEEE floating point representations and the respective
;; scheme types.  See the PLT manual for detailed descriptions.

;; This is the PLT interface without optional arguments, without the
;; ability to provide storage, and operating on <u8v> instead of
;; <bytes>.

(define (integer->u8v* n size-n signed? big-endian?)
  (integer->integer-bytes n size-n signed? big-endian?))

(define (u8v->integer* b signed? big-endian?)
  (integer-bytes->integer b
			  signed? 
			  big-endian?))

;; Variants that are extended to handle the case of one-byte integers.
;; In that case the endian indication is obviously meaningless.

(define (integer->u8v n size-n signed? big-endian?)
  (if (= size-n 1)
      (if signed?
	  (u8v (if (negative? n) (+ n 256) n))
	  (u8v n))
      (integer->u8v* n size-n signed? big-endian?)))

(define (u8v->integer b signed? big-endian?)
  (if (= (u8v-length b) 1)
      (let ((n (u8v-ref b 0)))
	(if (and signed? (> n 127))
	    (- n 256)
	    n))
      (u8v->integer* b signed? big-endian?)))
  
;; This is the PLT interface without optional arguments, without the
;; ability to provide storage, and operating on <u8v> instead of
;; <bytes>.

(define (real->u8v n size-n big-endian?)
  (real->floating-point-bytes n size-n big-endian?))

(define (u8v->real b big-endian?)
  (floating-point-bytes->real b big-endian?))

(define (u8v->i8  b) (u8v->integer b #t #t))
(define (u8v->u8  b) (u8v->integer b #f #t))
(define (u8v->i16 b) (u8v->integer b #t #t))
(define (u8v->u16 b) (u8v->integer b #f #t))
(define (u8v->i32 b) (u8v->integer b #t #t))
(define (u8v->u32 b) (u8v->integer b #f #t))
(define (u8v->i64 b) (u8v->integer b #t #t))
(define (u8v->u64 b) (u8v->integer b #f #t))
(define (u8v->f32 b) (u8v->real b #t))
(define (u8v->f64 b) (u8v->real b #t))

(define (i8->u8v  n) (integer->u8v n 1 #t #t))
(define (u8->u8v  n) (integer->u8v n 1 #f #t))
(define (i16->u8v n) (integer->u8v n 2 #t #t))
(define (u16->u8v n) (integer->u8v n 2 #f #t))
(define (i32->u8v n) (integer->u8v n 4 #t #t))
(define (u32->u8v n) (integer->u8v n 4 #f #t))
(define (i64->u8v n) (integer->u8v n 8 #t #t))
(define (u64->u8v n) (integer->u8v n 8 #f #t))
(define (f32->u8v n) (real->u8v n 4 #t))
(define (f64->u8v n) (real->u8v n 8 #t))

(define (u8v->pstring b)
  (u8v->string (u8v-copy* b 1 (+ (u8v-ref b 0) 1))))

(define (pstring->u8v s)
  (let ((b (string->u8v s)))
    (u8v-++ (u8v (u8v-length b)) b)))

(define (u8t->u8v t)
  (u8v-concat (flatten t)))

;; Procedures where the string variant takes or returns <char>'s here
;; take or return <integer>'s.

(define (u8v-index b k)
  (let ((start 0)
	(end (u8v-length b)))
    (let loop ((i start))
      (and (< i end)
	   (if (= k (u8v-ref b i))
	       i
	       (loop (+ i 1)))))))

(define (u8v-index-right b k) 
  (let ((start 0)
	(end (u8v-length b)))
    (let loop ((i (- end 1)))
      (and (>= i start)
	   (if (= k (u8v-ref b i)) 
	       i
	       (loop (- i 1)))))))
  
