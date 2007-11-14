;; int.scm - (c) rohan drape, 2006-2007

(module int scheme/base

(require (only-in "../mzscheme/r6rs.ss"
		  fxand
		  fxarithmetic-shift-left
		  fxarithmetic-shift-right)
	 (only-in srfi/1
		  fold
		  iota))

(provide int->u8l
	 u8l->int)

(define (byte n i)
  (fxand (fxarithmetic-shift-right i n) #xFF))

(define (int->u8l n size)
  (map (lambda (b)
	 (byte b n))
       (iota (/ size 8) (- size 8) -8)))

;; >=?

(define (sign n b)
  (let ((z (expt 2 b)))
    (if (> n (/ z 2))
	(- n z)
	n)))

(define (u8l->int l signed?)
  (let ((n (length l)))
    (let ((u (fold
	      + 0
	      (map fxarithmetic-shift-left
		   l
		   (iota n (* (- n 1) 8) -8)))))
      (if signed?
	  (sign u (* n 8))
	  u))))

#|
(u16->u8l 65191)
(u8l->u16 (list 254 167))

(i16->u8l -345)
(u8l->i16 (list 254 167))

(i16->u8l 345)
(u8l->i16 (list 1 89))
|#

)
