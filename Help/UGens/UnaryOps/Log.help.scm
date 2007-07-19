;; (Recip a)

;; Reciprocal.

(let* ((a (Line ar -2 2 2 removeSynth))
       (b (Recip a))
       (f (MulAdd (Mce a b) 600 900)))
  (Mul (SinOsc ar f 0) 0.1))
