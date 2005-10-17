;;; (Lag in lagTime)

;;; A simple averaging filter.

(let ((x (MouseX.kr 220 440)))
  (SinOsc.ar (list x (Lag.kr x 1)) 0 0.1))
