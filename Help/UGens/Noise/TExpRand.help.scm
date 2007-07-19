;; (TExpRand lo hi trig)

;; Generates a random float value in exponential distribution from lo
;; to hi each time the trig signal changes from nonpositive to
;; positive values lo and hi must both have the same sign and be
;; non-zero.

(let ((trig (Dust kr 10)))
  (Mul (SinOsc ar (TExpRand 300 3000 trig) 0)
       0.2))
