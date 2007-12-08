;; (Lag2 in lagTime)

;; Lag2 is the same as (Lag kr (Lag kr in time) time).

(let* ((x (MouseX kr 220 440 0 0.1))
       (f (Mce x (Lag2 x 1))))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.1))))
