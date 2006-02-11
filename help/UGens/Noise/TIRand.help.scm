;; (TIRand lo hi trig)

;; Generates a random integer value in uniform distribution from lo to
;; hi each time the trig signal changes from nonpositive to positive
;; values

(Pan2 (PinkNoise R0 ar) (TIRand R0 -1 1 (Dust R0 kr 10)) 0.2)

(Mul (SinOsc ar (MulAdd (TIRand R0 4 12 (Dust R0 kr 10)) 150 (Mce 0 1)) 0)
     0.1)
