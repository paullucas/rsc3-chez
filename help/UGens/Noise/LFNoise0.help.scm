;; (LFNoise0 freq)
;; (LFNoise1 freq)
;; (LFNoise2 freq)

;; LFNoise0 is step noise.  Generates random values at a rate given by
;; the nearest integer division of the sample rate by the freq
;; argument.

;; LFNoise1 is ramp noise.  Generates linearly interpolated random
;; values at a rate given by the nearest integer division of the
;; sample rate by the freq argument.

;; LFNoise2 is quadratic noise.  Generates quadratically interpolated
;; random values at a rate given by the nearest integer division of
;; the sample rate by the freq argument.
 
(Mul (LFNoise0 R0 ar 1000) 0.25)
(Mul (LFNoise1 R0 ar 1000) 0.25)
(Mul (LFNoise2 R0 ar 1000) 0.25)

;; Modulate frequency.

(Mul (LFNoise0 R0 ar (XLine kr 1000 10000 10 2)) 0.25)
(Mul (LFNoise1 R0 ar (XLine kr 1000 10000 10 2)) 0.25)
(Mul (LFNoise2 R0 ar (XLine kr 1000 10000 10 2)) 0.25)

;; Use as frequency control.

(Mul (SinOsc ar (MulAdd (LFNoise0 R0 kr 4) 400 450) 0) 0.2)
(Mul (SinOsc ar (MulAdd (LFNoise1 R0 kr 4) 400 450) 0) 0.2)
(Mul (SinOsc ar (MulAdd (LFNoise2 R0 kr 4) 400 450) 0) 0.2)
