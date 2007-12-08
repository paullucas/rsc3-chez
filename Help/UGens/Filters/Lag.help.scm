;; (Lag in lagTime)

;; A simple averaging filter.

(let* ((x (MouseX kr 220 440 0 0.1))
       (f (Mce x (Lag x 1))))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.1))))
