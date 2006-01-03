;; (PinkNoise)
 
;; Generates noise whose spectrum falls off in power by 3 dB per
;; octave.  This gives equal power over the span of each octave.  This
;; version gives 8 octaves of pink noise.
 
(PinkNoise ar 0.5)
(BrownNoise ar 0.5)
(WhiteNoise ar 0.5)
