;; (IRand lo hi)

;; Generates a single random integer value in uniform distribution
;; from `lo' to `hi'.

(Mul (FSinOsc ar (IRand 200 1200) 0)
     (Line kr 0.2 0 0.1 removeSynth))
