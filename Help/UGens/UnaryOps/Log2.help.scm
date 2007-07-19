;; (Log2 a)

;; Base two logarithm.

(let* ((a (Line ar -2 2 3 removeSynth))
       (b (Log2 a))
       (f (MulAdd (Mce a b) 600 900)))
  (Mul (SinOsc ar f 0) 0.1))
