;; (PulseDivider trig div start)

;; Outputs one impulse each time it receives a certain number of
;; triggers at its input.  A trigger happens when the signal changes
;; from non-positive to positive.

(let* ((p (Impulse ar 8 0))
       (d (PulseDivider p (Mce 4 7) 0))
       (a (Mul (SinOsc ar 1200 0) (Decay2 p 0.005 0.1)))
       (b (Mul (SinOsc ar 600 0)  (Decay2 d 0.005 0.5))))
  (audition (Out 0 (Mul (Add a b) 0.4))))
