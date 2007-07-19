;; (ToggleFF trig)

;; Toggle flip flop. Toggles between zero and one upon receiving a trigger.

;; trig - trigger input

(let ((t (Dust ar (XLine kr 1 1000 60 doNothing))))
  (Mul (SinOsc ar (MulAdd (ToggleFF t) 400 800) 0) 0.1))
