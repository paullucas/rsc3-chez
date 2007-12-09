;; (IRand lo hi)

;; Generates a single random integer value in uniform distribution
;; from `lo' to `hi'.

(let ((f (IRand 200 1200))
      (a (Line kr 0.2 0 0.1 removeSynth)))
  (audition (Out 0 (Mul (FSinOsc ar f 0) a))))
