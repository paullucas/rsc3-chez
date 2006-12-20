;; (SinH a)

;; Sine.

(let* ((a (Line kr (- pi) pi 1 removeSynth))
       (b (Sub (FDiv (SinH a) (/ pi 2)) 1))
       (f (MulAdd b 900 1600)))
  (Mul (SinOsc ar f 0) 0.1))
