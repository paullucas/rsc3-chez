;; (Dust rate density)

;; Generates random impulses from 0 to +1 at a rate determined by the
;; density argument.

(audition (Out 0 (Mul (Dust ar 200) 0.5)))

(let ((r (XLine kr 20000 2 10 removeSynth)))
  (audition (Out 0 (Mul (Dust ar r) 0.5))))
