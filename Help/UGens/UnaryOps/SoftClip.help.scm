;; (SoftClip a)

;; Nonlinear distortion.  Distortion with a perfectly linear region
;; from -0.5 to +0.5.

(Mul (Distort (Mul (FSinOsc ar 500 0.0)
		   (XLine kr 0.1 10 10 doNothing)))
     0.25)
