;; (SqrDif a b)

;; Square of the difference.  Return the value of (a - b)**2. This is
;; more efficient than using separate unit generators for each
;; operation.

(Mul (SqrDif (FSinOsc ar 800 0)
	     (FSinOsc ar (XLine kr 200 500 5 0) 0))
     0.125)

(let ((a (FSinOsc ar 800 0))
      (b (FSinOsc ar (XLine kr 200 500 5 0) 0)))
  (Mul (Mul (Sub a b) (Sub a b))
       0.125))
