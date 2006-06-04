;; u8l.scm - (c) rohan drape, 2001-2006

;; u8? :: u8 -> true

(define (u8? b)
  (and (integer? b)
       (>= b 0)
       (< b 256)))

;; u8? :: [u8] -> true

(define (u8l? l)
  (and (list? l)
       (every u8? l)))

;; Decoders

(define (u8l->u8  l) (list-ref l 0))
(define (u8l->u16 l) (u8l->int l 2 #f))
(define (u8l->u32 l) (u8l->int l 4 #f))
(define (u8l->u64 l) (u8l->int l 8 #f))
(define (u8l->i16 l) (u8l->int l 2 #t))
(define (u8l->i32 l) (u8l->int l 4 #t))
(define (u8l->i64 l) (u8l->int l 8 #t))
(define (u8l->f32 l) (u8l->real l 4))
(define (u8l->f64 l) (u8l->real l 8))

;; Encoders

(define (u8->u8l  n) (list n))
(define (u16->u8l n) (int->u8l n 2 #f))
(define (u32->u8l n) (int->u8l n 4 #f))
(define (u64->u8l n) (int->u8l n 8 #f))
(define (i16->u8l n) (int->u8l n 2 #t))
(define (i32->u8l n) (int->u8l n 4 #t))
(define (i64->u8l n) (int->u8l n 8 #t))
(define (f32->u8l n) (real->u8l n 4))
(define (f64->u8l n) (real->u8l n 8))

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
    ((u8)   read-u8)
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
