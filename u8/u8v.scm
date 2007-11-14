;; u8v.scm - (c) rohan drape, 2006-2007

(module u8v scheme/base

(require (only-in srfi/43
		  vector-every)
	 (only-in "u8.scm"
		  u8?
		  i8->u8
		  u8->i8)
	 "u8l.scm")

(provide u8v?
	 i8->u8v
	 i16->u8v
	 i32->u8v
	 i64->u8v
	 u8->u8v
	 u16->u8v
	 u32->u8v
	 u64->u8v
	 f32->u8v
	 f64->u8v
	 u8v->i8
	 u8v->i16
	 u8v->i32
	 u8v->i64
	 u8v->u8
	 u8v->u16
	 u8v->u32
	 u8v->u64
	 u8v->f32
	 u8v->f64
	 u8v->str
	 str->u8v
	 file->u8v)

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

)
