;; (Dust2 rate density)

;; Generates random impulses from -1 to +1.  The `density' is in
;; impulses per second.

(audition (Out 0 (Mul (Dust2 ar 200) 0.5)))

(let ((r (XLine kr 20000 2 10 removeSynth)))
  (audition (Out 0 (Mul (Dust2 ar r) 0.5))))
