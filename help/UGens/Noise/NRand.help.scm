;; (NRand lo hi n)
 
;; Generates a single random float value in a sum of `n' uniform
;; distributions from `lo' to `hi'.
 
;; n = 1 : uniform distribution - same as Rand
;; n = 2 : triangular distribution
;; n = 3 : smooth hump
;; as n increases, distribution converges towards gaussian

(Mul (FSinOsc ar (Mul (NRand R0 ir 1200 4000 2) (Mce 2 5)) 0)
     (Line kr 0.2 0 0.01 2))
