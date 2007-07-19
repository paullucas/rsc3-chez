;; (Distort a)

;; Nonlinear distortion.

(Mul (Distort (Mul (FSinOsc ar 500 0.0)
		   (XLine kr 0.1 10 10 doNothing)))
     0.25)
