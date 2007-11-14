;; common.scm - (c) rohan drape, 2005-2007

(module common scheme/base

(provide squared
	 cubed
	 recip)

(define (squared n)
  (* n n))

(define (cubed n)
  (* n n n))

(define (recip n)
  (/ 1 n))

)
