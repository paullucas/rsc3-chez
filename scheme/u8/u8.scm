;; u8.scm - (c) rohan drape, 2006-2007

(module u8 (lib "lang.ss" "r5rs")
(#%provide (all-defined))

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

)
