;; (ToggleFF trig)

;; Toggle flip flop. Toggles between zero and one upon receiving a trigger.

;; trig - trigger input

(Mul (SinOsc ar (MulAdd (ToggleFF (Dust ar (XLine kr 1 1000 60 doNothing))) 400 800) 0) 
     0.1)
