;; (NRand lo hi n)
 
;; Generates a single random float value in a sum of `n' uniform
;; distributions from `lo' to `hi'.
 
;; n = 1 : uniform distribution - same as Rand
;; n = 2 : triangular distribution
;; n = 3 : smooth hump
;; as n increases, distribution converges towards gaussian

(let ((f (Mul (NRand 1200 4000 2) (Mce 2 5)))
      (a (Line kr 0.2 0 0.01 removeSynth)))
  (audition (Out 0 (Mul (FSinOsc ar f 0) a))))
