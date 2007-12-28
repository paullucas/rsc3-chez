;; u8l.scm - (c) rohan drape, 2001-2007

(module u8l scheme/base

(require (only-in "../mzscheme/r6rs.ss"
		  make-bytevector
		  bytevector-ieee-single-set!
		  bytevector-ieee-double-set!
		  bytevector->u8-list
		  u8-list->bytevector
		  bytevector-length
		  bytevector-ieee-single-ref
		  bytevector-ieee-double-ref
		  endianness
		  open-bytevector-input-port
		  call-with-bytevector-output-port
		  get-u8
		  put-u8
		  lookahead-u8)
	 (only-in srfi/1
		  every
		  iota
		  list-index
		  take)
	 (only-in srfi/39
		  parameterize)
	 (only-in "u8.scm"
		  i8->u8
		  u8?
		  u8->i8)
	 (only-in "int.scm"
		  int->u8l
		  u8l->int))

(provide u8l?
	 u8l->int
	 int->u8l
	 i8->u8l
	 i16->u8l
	 i32->u8l
	 i64->u8l
	 u8->u8l
	 u16->u8l
	 u32->u8l
	 u64->u8l
	 f32->u8l
	 f64->u8l
	 u8l->i8
	 u8l->i16
	 u8l->i32
	 u8l->i64
	 u8l->u8
	 u8l->u16
	 u8l->u32
	 u8l->u64
	 u8l->f32
	 u8l->f64
	 cstr->u8l
	 pstr->u8l
	 u8l->pstr
	 u8l->cstr
	 str->u8l
	 u8l->str
	 read-u8l
	 read-cstr
	 read-pstr
	 read-i16
	 read-i32
	 read-i64
	 read-u16
	 read-u32
	 read-u64
	 read-f32
	 read-f64
	 read-bstr
	 write-u8l
	 file->u8l
	 with-input-from-u8l
	 with-output-to-u8l)

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
       (every u8? l)))

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
  (list->string (map integer->char (take l n))))

(define (u8l->pstr l)
  (let ((n (car l))
	(l* (cdr l)))
    (u8l->str l* n)))

(define (u8l->cstr l)
  (let ((n (list-index (lambda (b) (= b 0)) l)))
    (u8l->str l n)))

(define (str->u8l s)
  (map char->integer (string->list s)))

(define (pstr->u8l s)
  (cons (string-length s) (str->u8l s)))

(define (cstr->u8l s)
  (append (str->u8l s) (list 0)))

;; read-u8l :: int -> IO [u8]

(define (read-u8l n)
  (map (lambda (_) (get-u8 (current-input-port))) (iota n)))

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

)
