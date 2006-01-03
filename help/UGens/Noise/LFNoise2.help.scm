;; (LFNoise2 freq)
 
;; Quadratic noise.  Generates quadratically interpolated random
;; values at a rate given by the nearest integer division of the
;; sample rate by the freq argument.
 
(LFNoise2 ar 1000 0.25)

;; Modulate frequency 

(LFNoise2 ar (XLine kr 1000 10000 10) 0.25)

;; Use as frequency control 

(SinOsc ar (LFNoise2 kr 4 400 450) 0 0.2)
