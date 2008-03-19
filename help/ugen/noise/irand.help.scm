;; (irand lo hi)

;; Generates a single random integer value in uniform distribution
;; from `lo' to `hi'.

(let ((f (irand 200 1200))
      (a (line kr 0.2 0 0.1 remove-synth)))
  (audition (out 0 (mul (fsin-osc ar f 0) a))))
