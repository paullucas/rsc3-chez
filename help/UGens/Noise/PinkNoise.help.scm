;; (PinkNoise)

;; Generates noise whose spectrum falls off in power by 3 dB per
;; octave.  This gives equal power over the span of each octave.  This
;; version gives 8 octaves of pink noise.

(Mul (PinkNoise  0 ar) 0.5)
(Mul (BrownNoise 0 ar) 0.5)
(Mul (WhiteNoise 0 ar) 0.5)
