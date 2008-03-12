;; u8v

#|
(define u8v?
(lambda (v)
  (and (vector? v)
       (vector-every u8? v)))

(define u8l->u8v list->vector)
(define u8v->u8l vector->list)

(define u8->u8v
(lambda ( n)   (vector n))
(define u16->u8v
(lambda (n)   (u8l->u8v (u16->u8l n)))
(define u32->u8v
(lambda (n)   (u8l->u8v (u32->u8l n)))
(define u64->u8v
(lambda (n)   (u8l->u8v (u64->u8l n)))
(define i8->u8v
(lambda ( n)   (u8->u8v (i8->u8 n)))
(define i16->u8v
(lambda (n)   (u8l->u8v (i16->u8l n)))
(define i32->u8v
(lambda (n)   (u8l->u8v (i32->u8l n)))
(define i64->u8v
(lambda (n)   (u8l->u8v (i64->u8l n)))
(define f32->u8v
(lambda (n)   (u8l->u8v (f32->u8l n)))
(define f64->u8v
(lambda (n)   (u8l->u8v (f64->u8l n)))
(define str->u8v
(lambda (s)   (u8l->u8v (str->u8l s)))

(define u8v->u8
(lambda (v)    (vector-ref v 0))
(define u8v->u16
(lambda (v)   (u8l->u16 (u8v->u8l v)))
(define u8v->u32
(lambda (v)   (u8l->u32 (u8v->u8l v)))
(define u8v->u64
(lambda (v)   (u8l->u64 (u8v->u8l v)))
(define u8v->i8
(lambda (v)    (u8->i8 (u8v->u8 v)))
(define u8v->i16
(lambda (v)   (u8l->i16 (u8v->u8l v)))
(define u8v->i32
(lambda (v)   (u8l->i32 (u8v->u8l v)))
(define u8v->i64
(lambda (v)   (u8l->i64 (u8v->u8l v)))
(define u8v->f32
(lambda (v)   (u8l->f32 (u8v->u8l v)))
(define u8v->f64
(lambda (v)   (u8l->f64 (u8v->u8l v)))
(define u8v->str
(lambda (v n) (u8l->str (u8v->u8l v) n))

(define file->u8v
(lambda (f)
  (u8l->u8v (file->u8l f)))
|#
