;; (TIRand lo hi trig)

;; Generates a random integer value in uniform distribution from lo to
;; hi each time the trig signal changes from nonpositive to positive
;; values

(Pan2 (PinkNoise ar) (TIRand -1 1 (Dust kr 10)) 0.2)

(Mul (SinOsc ar (MulAdd (TIRand 4 12 (Dust kr 10)) 150 (Mce 0 1)) 0)
     0.1)
