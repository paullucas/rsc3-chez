;; (Softclip a)

;; Nonlinear distortion.  Distortion with a perfectly linear region
;; from -0.5 to +0.5.

(mul (Distort (Mul (fsin-osc ar 500 0.0)
		   (xline kr 0.1 10 10 do-nothing)))
     0.25)
