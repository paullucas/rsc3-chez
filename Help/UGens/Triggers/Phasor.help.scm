;; (Phasor trig rate start end resetpos)

;; Triggered linear ramp between two levels.  Starts a linear ramp
;; when trig input crosses from non-positive to positive.

;; trig       - sets phase to resetPos (default: 0, equivalent to start)
;; rate       - rate value in 1 / frameDur (at 44.1 kHz sample rate: rate 
;;              1 is eqivalent to 44100/sec)
;; start, end - start and end points of ramp
;; resetPos   - determines where to jump to on recieving a trigger.  the
;;		value at that position can be calculated as follows:
;;		(end - start) * resetPos

;; phasor controls sine frequency: end frequency matches a second sine wave.

(let* ((r (MouseX kr 0.2 2 1 0.1))
       (t (Impulse ar r 0))
       (x (Phasor ar t (FDiv r SampleRate) 0 1 0))
       (f (Mce (LinLin x 0 1 600 1000) 1000)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.2))))
