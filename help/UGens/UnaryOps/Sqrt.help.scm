;; (Sqrt a)

;; Square root.  The definition of square root is extended for signals
;; so that sqrt(a) when a<0 returns -sqrt(-a).

(let* ((a (Line ar -2 2 3 removeSynth))
       (b (Sqrt a))
       (f (MulAdd (Mce a b) 600 900)))
  (Mul (SinOsc ar f 0) 0.1))
