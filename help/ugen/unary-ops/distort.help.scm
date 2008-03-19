;; (distort a)

;; Nonlinear distortion.

(audition 
   (out 0 (mul (distort (mul (fsin-osc ar 500 0.0)
			     (xline kr 0.1 10 10 do-nothing)))
	       0.25)))
