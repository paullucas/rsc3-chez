;; (ExpRand lo hi)

;; Generates a single random float value in an exponential
;; distributions from `lo' to `hi'.

(Mul (FSinOsc ar (ExpRand 100 8000) 0)
     (Line kr 0.5 0 0.01 2))
