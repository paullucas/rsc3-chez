;; (Dust2 rate density)

;; Generates random impulses from -1 to +1.  The `density' is in
;; impulses per second.

(Mul (Dust2 ar 200) 0.5)

(Mul (Dust2 ar (XLine kr 20000 2 10 removeSynth)) 0.5)