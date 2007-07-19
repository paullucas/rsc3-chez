;; (Lag2 in lagTime)

;; Lag3 is the same as (Lag (Lag (Lag in time) time) time).

(let ((x (MouseX kr 220 440 0 0.1)))
  (Mul (SinOsc ar (Mce x (Lag3 x 1)) 0) 0.1))
