;; in.scm - (c) rohan drape, 2003-2006

;; Audio input.  Does not support MulAdd.

(define (consecutive? l)
  (let ((x (car l))
	(xs (cdr l)))
    (or (null? xs)
	(and (= (+ x 1) (car xs))
	     (consecutive? xs)))))

(define (audioin n)
  (let ((offset (Sub (NumOutputBuses ir) 1)))
    (if (mce? n)
	(let ((l (mce-channels n)))
	  (if (consecutive? l)
	      (In ar (Add offset (car l)) (length l))
	      (In ar (Add offset n) 1)))
	(In ar (Add offset n) 1))))
