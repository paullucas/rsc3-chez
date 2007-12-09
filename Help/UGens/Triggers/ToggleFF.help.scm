;; (ToggleFF trig)

;; Toggle flip flop. Toggles between zero and one upon receiving a trigger.

;; trig - trigger input

(let* ((t (Dust ar (XLine kr 1 1000 60 doNothing)))
       (s (SinOsc ar (MulAdd (ToggleFF t) 400 800) 0)))
  (audition (Out 0 (Mul s 0.1))))
