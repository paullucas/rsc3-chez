;; (Lag in lagTime)

;; A simple averaging filter.

(let ((x (MouseX kr 220 440 0 0.1)))
  (Mul (SinOsc ar (Mce x (Lag x 1)) 0) 0.1))
