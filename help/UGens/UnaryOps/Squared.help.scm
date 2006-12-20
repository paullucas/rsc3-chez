;; (Squared a)

;; Square.

(let* ((a (Line ar -2 2 3 removeSynth))
       (b (Squared a))
       (f (MulAdd (Mce a b) 600 900)))
  (Mul (SinOsc ar f 0) 0.1))
