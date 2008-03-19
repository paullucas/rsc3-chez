;; (two-pole in freq radius)

;; Two pole filter.  This provides lower level access to setting of
;; pole location.  For general purposes resonz is better.

(two-pole (mul (white-noise ar) 0.005) 2000 0.95)

(two-pole (mul (white-noise ar) 0.005) 
	 (xline kr 800 8000 8 remove-synth)
	 0.95)
