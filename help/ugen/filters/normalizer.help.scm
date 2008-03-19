;; (normalizer in level dur) 

;; Flattens dynamics.

(let ((z (mul (decay2 (impulse ar 8 (Mul (lfsaw kr 0.25 -0.6) 0.7))
		      0.001  
		      0.3)
	      (fsin-osc ar 500 0))))
  (Mce z (normalizer z 0.4 0.01)))
