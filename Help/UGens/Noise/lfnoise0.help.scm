;; (lfnoise0 rate freq)
;; (lfnoise1 rate freq)
;; (lfnoise2 rate freq)

;; lfnoise0 is step noise.  Generates random values at a rate given by
;; the nearest integer division of the sample rate by the freq
;; argument.

;; lfnoise1 is ramp noise.  Generates linearly interpolated random
;; values at a rate given by the nearest integer division of the
;; sample rate by the freq argument.

;; lfnoise2 is quadratic noise.  Generates quadratically interpolated
;; random values at a rate given by the nearest integer division of
;; the sample rate by the freq argument.

(audition (out 0 (mul (lfnoise0 ar 1000) 0.25)))
(audition (out 0 (mul (lfnoise1 ar 1000) 0.25)))
(audition (out 0 (mul (lfnoise2 ar 1000) 0.25)))

;; Modulate frequency.

(audition (out 0 (mul (lfnoise0 ar (xline kr 1000 10000 10 remove-synth)) 0.25)))
(audition (out 0 (mul (lfnoise1 ar (xline kr 1000 10000 10 remove-synth)) 0.25)))
(audition (out 0 (mul (lfnoise2 ar (xline kr 1000 10000 10 remove-synth)) 0.25)))

;; Use as frequency control.

(audition (out 0 (mul (sin-osc ar (mul-add (lfnoise0 kr 4) 400 450) 0) 0.2)))
(audition (out 0 (mul (sin-osc ar (mul-add (lfnoise1 kr 4) 400 450) 0) 0.2)))
(audition (out 0 (mul (sin-osc ar (mul-add (lfnoise2 kr 4) 400 450) 0) 0.2)))
