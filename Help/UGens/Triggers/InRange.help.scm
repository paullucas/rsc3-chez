;; (InRange in lo hi)

;; Tests if a signal is within a given range.

;; If in is >= lo and <= hi output 1.0, otherwise output 0.0. Output
;; is initially zero.

;; in - signal to be tested
;; lo - low threshold
;; hi - high threshold

(let ((a (InRange (Mul (SinOsc kr 1 0) 0.2) -0.15 0.15)))
  (audition (Out 0 (Mul a (Mul (BrownNoise ar) 0.1)))))
