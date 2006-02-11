;; (Dust density)

;; Generates random impulses from 0 to +1 at a rate determined by the
;; density argument.

(Mul (Dust R0 ar 200) 0.5)

(Mul (Dust R0 ar (XLine kr 20000 2 10 2)) 0.5)
