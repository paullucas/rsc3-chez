;; (ExpRand lo hi)

;; Generates a single random float value in an exponential
;; distributions from `lo' to `hi'.

(let ((f (ExpRand 100 8000))
      (a (Line kr 0.5 0 0.01 removeSynth)))
  (audition (Out 0 (Mul (FSinOsc ar f 0) a))))
