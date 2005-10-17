;; (LFNoise0 freq)

;; Step noise.  Generates random values at a rate given by the nearest
;; integer division of the sample rate by the freq argument.

(LFNoise0.ar 1000 0.25)

;; Modulate frequency.

(LFNoise0.ar (XLine.kr 1000 10000 10) 0.25)

;; Use as frequency control.

(SinOsc.ar (LFNoise0.kr 4 400 450) 0 0.2)
