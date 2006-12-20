;; (SumSqr a b)

;; Return the value of (a*a) + (b*b). This is more efficient than
;; using separate unit generators for each operation.

(Mul (SumSqr (FSinOsc ar 800 0) 
	     (FSinOsc ar (XLine kr 200 500 5 doNothing) 0)) 
     0.125)

(let ((a (FSinOsc ar 800 0))
      (b (FSinOsc ar (XLine kr 200 500 5 doNothing) 0)))
  (Mul (Add (Mul a a) (Mul b b)) 0.125))
