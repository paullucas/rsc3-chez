;; in.scm - (c) rohan drape, 2003-2005

;; Audio input.  Does not support MulAdd.

(defineH consecutive? (cons x xs)
  (or (null? xs)
      (and (= (+ x 1) (car xs))
	   (consecutive? xs))))

(define (audioin channel)
  (let ((offset (-u (NumOutputBuses ir) 1)))
    (if (not (list? channel))
	(In ar (+u offset channel))
	(if (consecutive? channel)
	    (In ar (+u offset (car channel)) (length channel))
	    (In ar (+u offset channel))))))
