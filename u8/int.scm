;; int.scm - (c) rohan drape, 2006-2007

(module int (lib "lang.ss" "r5rs")
(#%require (only "../mzscheme/bits.ss"
		 arithmetic-shift
		 bitwise-and)
	   (only (lib "1.ss" "srfi")
		 fold
		 iota))
(#%provide shiftR 
	   shiftL
	   int->u8l
	   u8l->int)

(define (shiftR i n)
  (arithmetic-shift i (- n)))

(define (shiftL i n)
  (arithmetic-shift i n))

(define (byte n i)
  (bitwise-and (shiftR i n) #xFF))

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
	      (map shiftL
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
