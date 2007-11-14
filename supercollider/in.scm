;; in.scm - (c) rohan drape, 2003-2007

(module in scheme/base

(require "../graphdef/mce.scm"
	 "../graphdef/rate.scm"
	 "../ugen/operator.scm"
	 "../ugen/oscillator.scm"
	 "../ugen/specialized.scm")

(provide (all-defined-out))

;; Audio input.  Does not support MulAdd.

(define (consecutive? l)
  (let ((x (car l))
	(xs (cdr l)))
    (or (null? xs)
	(and (= (+ x 1) (car xs))
	     (consecutive? xs)))))

(define (audioin n)
  (let ((offset (Sub NumOutputBuses 1)))
    (if (mce? n)
	(let ((l (mce-channels n)))
	  (if (consecutive? l)
	      (In (length l) ar (Add offset (car l)))
	      (In 1 ar (Add offset n))))
	(In 1 ar (Add offset n)))))

)
