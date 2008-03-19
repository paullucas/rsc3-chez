;; (two-zero in freq radius)

;; Two zero filter

(two-zero (mul (white-noise ar) 0.125) 
	 (xline kr 20 20000 8 remove-synth) 
	 1)
