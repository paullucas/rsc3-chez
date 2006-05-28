;; u8v.scm - (c) rohan drape, 2001-2006

;; Core.  PLT provides two incompatible types for byte vectors,
;; <bytes> and <u8vector>.  This aliases <u8v> to <bytes>.

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
(define read-u8v         read-bytes)
(define write-u8v        write-bytes)
(define open-input-u8v   open-input-bytes)
(define open-output-u8v  open-output-bytes)
(define get-output-u8v   get-output-bytes)
(define u8v->list        bytes->list)
(define list->u8v        list->bytes)
(define u8v->string      bytes->string/utf-8)
(define string->u8v      string->bytes/utf-8)

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

;; Derived.

(define (u8v-++ a b)     (u8v-append a b))
(define (u8v-concat l)   (fold-right u8v-++ (u8v) l))

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
  
;; Read a file as a byte vector.

(define (file->u8v file)
  (let* ((port (open-input-file file))
	 (u8v (read-u8v (file-size file) port)))
    (close-input-port port)
    u8v))

;; Write each u8v at t to p.

(define (u8t->port t p)
  (for-each (lambda (b) (write-u8v b p))
	    (flatten t)))

;; ALTERNATIVE

(define str->u8v  string->u8v)
(define pstr->u8v pstring->u8v)

(define-structure u8e t n)

(define (i8   n) (make-u8e 'i8   n))
(define (u8   n) (make-u8e 'u8   n))
(define (i16  n) (make-u8e 'i16  n))
(define (u16  n) (make-u8e 'u16  n))
(define (i32  n) (make-u8e 'i32  n))
(define (u32  n) (make-u8e 'u32  n))
(define (i64  n) (make-u8e 'i64  n))
(define (u64  n) (make-u8e 'u64  n))
(define (f32  n) (make-u8e 'f32  n))
(define (f64  n) (make-u8e 'f64  n))
(define (str  n) (make-u8e 'str  n))
(define (pstr n) (make-u8e 'pstr n))
(define (u8v* n) (make-u8e 'u8v  n))

(define (u8V e)
  (let ((t (u8e-t e))
	(n (u8e-n e)))
    (case t
      ((i8)   (i8->u8v   n))
      ((u8)   (u8->u8v   n))
      ((i16)  (i16->u8v  n))
      ((u16)  (u16->u8v  n))
      ((i32)  (i32->u8v  n))
      ((u32)  (u32->u8v  n))
      ((i64)  (i64->u8v  n))
      ((u64)  (u64->u8v  n))
      ((f32)  (f32->u8v  n))
      ((f64)  (f64->u8v  n))
      ((str)  (str->u8v  n))
      ((pstr) (pstr->u8v n))
      ((u8v)  n)
      (else   (error "u8V: illegal value" t n)))))

(define (u8w l p)
  (let ((f (lambda (e) (write-u8v (u8V e) p))))
    (for-each f (flatten l))))

(define (mk-u8v l)
  (let ((p (open-output-u8v)))
    (u8w l p)
    (get-output-u8v p)))

(define (_i8   p) (u8v->i8  (read-u8v 1 p)))
(define (_u8   p) (u8v->u8  (read-u8v 1 p)))
(define (_i16  p) (u8v->i16 (read-u8v 2 p)))
(define (_u16  p) (u8v->u16 (read-u8v 2 p)))
(define (_i32  p) (u8v->i32 (read-u8v 4 p)))
(define (_u32  p) (u8v->u32 (read-u8v 4 p)))
(define (_i64  p) (u8v->i64 (read-u8v 8 p)))
(define (_u64  p) (u8v->u64 (read-u8v 8 p)))
(define (_f32  p) (u8v->f32 (read-u8v 4 p)))
(define (_f64  p) (u8v->f64 (read-u8v 8 p)))
(define (_pstr p) (u8v->string (read-u8v (_u8 p) p)))

