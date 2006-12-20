;; (TwoPole in freq radius)

;; Two pole filter.  This provides lower level access to setting of
;; pole location.  For general purposes Resonz is better.

(TwoPole (Mul (WhiteNoise ar) 0.005) 2000 0.95)

(TwoPole (Mul (WhiteNoise ar) 0.005) 
	 (XLine kr 800 8000 8 removeSynth)
	 0.95)
