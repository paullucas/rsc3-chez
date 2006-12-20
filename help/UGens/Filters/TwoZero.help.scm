;; (TwoZero in freq radius)

;; Two zero filter

(TwoZero (Mul (WhiteNoise ar) 0.125) 
	 (XLine kr 20 20000 8 removeSynth) 
	 1)
