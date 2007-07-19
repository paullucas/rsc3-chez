;; (OneZero in coef)

;; One zero filter

(OneZero (Mul (WhiteNoise ar) 0.5) 0.5)

(OneZero (Mul (WhiteNoise ar) 0.5) -0.5)

(OneZero (Mul (WhiteNoise ar) 0.5) (Line kr -0.5 0.5 10 removeSynth))
