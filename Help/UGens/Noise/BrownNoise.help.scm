;; (BrownNoise rate)

;; Generates noise whose spectrum falls off in power by 6 dB per
;; octave.

(audition (Out 0 (Mul (BrownNoise ar) 0.1)))
