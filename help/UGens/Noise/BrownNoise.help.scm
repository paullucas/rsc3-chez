;; (BrownNoise)

;; Generates noise whose spectrum falls off in power by 6 dB per
;; octave.

(Mul (BrownNoise ar) 0.1)
(Mul (WhiteNoise ar) 0.1)
