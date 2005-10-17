;; in.scm - (c) rohan drape, 2003-2005

;; Audio input.  Does not support MulAdd.

(defineH consecutive? (cons x xs)
  (or (null? xs)
      (and (= (+ x 1) (car xs))
	   (consecutive? xs))))

(define (AudioIn.ar channel)
  (let ((offset (-.ir (NumOutputBuses.ir) 1)))
    (if (not (list? channel))
	(In.ar (+.gr offset channel))
	(if (consecutive? channel)
	    (In.ar (+.gr offset (car channel)) (length channel))
	    (In.ar (+.gr offset channel))))))
