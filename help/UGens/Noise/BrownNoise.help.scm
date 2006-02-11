;; (BrownNoise)

;; Generates noise whose spectrum falls off in power by 6 dB per
;; octave.

(Mul (BrownNoise R0 ar) 0.1)
(Mul (WhiteNoise R0 ar) 0.1)
