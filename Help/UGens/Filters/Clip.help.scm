;; (Clip in lo hi)

;; Clip `in' to lie between `lo' and `hi', which are i-rate inputs.

(audition (Out 0 (Clip (Mul (SinOsc ar 440 0) 0.4) -0.25 0.25)))
