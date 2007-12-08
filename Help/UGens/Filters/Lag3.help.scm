;; (Lag3 in lagTime)

;; Lag3 is the same as (Lag (Lag (Lag in time) time) time).

(let* ((x (MouseX kr 220 440 0 0.1))
       (f (Mce x (Lag3 x 1))))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.1))))
