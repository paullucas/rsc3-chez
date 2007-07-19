;; (ArcTan a)

;; Arc tan.

(let* ((a (Line kr -1 1 1 removeSynth))
       (b (Sub (FDiv (ArcTan a) (/ pi 2)) 1))
       (f (MulAdd b 900 1600)))
  (Mul (SinOsc ar f 0) 0.1))
