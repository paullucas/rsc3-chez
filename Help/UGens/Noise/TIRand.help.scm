;; (TIRand lo hi trig)

;; Generates a random integer value in uniform distribution from lo to
;; hi each time the trig signal changes from nonpositive to positive
;; values

(let ((p (TIRand -1 1 (Dust kr 10))))
  (audition (Out 0 (Pan2 (PinkNoise ar) p 0.2))))

(let ((f (MulAdd (TIRand 4 12 (Dust kr 10)) 150 (Mce 0 1))))
  (audition (Out 0 (Mul (SinOsc ar f 0)	0.1))))
