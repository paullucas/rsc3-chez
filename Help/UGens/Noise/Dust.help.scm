;; (Dust rate density)

;; Generates random impulses from 0 to +1 at a rate determined by the
;; density argument.

(Mul (Dust ar 200) 0.5)

(Mul (Dust ar (XLine kr 20000 2 10 removeSynth)) 0.5)
