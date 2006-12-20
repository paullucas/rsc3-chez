;; (Sign a)

;; Sign function.  -1 when a < 0, +1 when a > 0, 0 when a is 0

(let* ((a (Line ar -1 1 1 removeSynth))
       (b (Sign a))
       (f (MulAdd (Mce a b) 600 900)))
  (Mul (SinOsc ar f 0) 0.1))
