;; (BrownNoise)

;; Generates noise whose spectrum falls off in power by 6 dB per
;; octave.

(Mul (BrownNoise r0 ar) 0.1)
(Mul (WhiteNoise r0 ar) 0.1)
