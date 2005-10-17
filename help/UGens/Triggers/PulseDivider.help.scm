;;; (PulseDivider trig div start)
 
;;; Outputs one impulse each time it receives a certain number of
;;; triggers at its input.  A trigger happens when the signal changes
;;; from non-positive to positive.

(let* ((p (Impulse.ar 8))
       (a (SinOsc.ar 1200 0 (Decay2.ar p 0.005 0.1)))
       (b (SinOsc.ar 600 0 (Decay2.ar (PulseDivider.ar p '(4 7)) 0.005 0.5))))
  (Mul (Add a b) 0.4))
