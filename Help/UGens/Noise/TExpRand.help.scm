;; (TExpRand lo hi trig)

;; Generates a random float value in exponential distribution from lo
;; to hi each time the trig signal changes from nonpositive to
;; positive values lo and hi must both have the same sign and be
;; non-zero.

(let* ((t (Dust kr 10))
       (f (TExpRand 300 3000 t)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.2))))
