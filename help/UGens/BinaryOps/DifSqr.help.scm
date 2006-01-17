;; (DifSqr a b)

;; Difference of squares.  Return the value of (a*a) - (b*b). This is
;; more efficient than using separate unit generators for each
;; operation.

(Mul (DifSqr (FSinOsc ar 800 0)
	     (FSinOsc ar (XLine kr 200 500 5 0) 0))
     0.125)

(let ((a (FSinOsc ar 800 0))
      (b (FSinOsc ar (XLine kr 200 500 5 0) 0)))
  (Mul (Sub (Mul a a) (Mul b b)) 0.125))
