;; (LFNoise1 freq)

;; Ramp noise.  Generates linearly interpolated random values at a
;; rate given by the nearest integer division of the sample rate by
;; the freq argument.

;; freq - approximate rate at which to generate random values.

(LFNoise1 ar 1000 0.25)

(LFNoise1 ar (XLine kr 1000 10000 10) 0.25)

(SinOsc ar (LFNoise1 kr 4 400 450) 0 0.2)
