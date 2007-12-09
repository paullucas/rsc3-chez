;; (MostChange a b)

;; Output the input that changed most.

(let* ((x (MouseX kr 200 300 0 0.1))
       (f (MostChange (MulAdd (LFNoise0 kr 1) 400 900) x)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.1))))
