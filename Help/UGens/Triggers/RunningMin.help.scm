;; (RunningMin in trig)

;; Track minimum level.  Outputs the minimum value received at the
;; input.  When triggered, the minimum output value is reset to the
;; current value.

;; in   - input signal
;; trig - reset the output value to the current input value

(let* ((t (Impulse ar 2.0 0))
       (f (MulAdd (RunningMin (Sub 1 (Dust ar 20)) t) 500 200)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.2))))

(let* ((t (Impulse kr (MouseX kr 0.5 4 1 0.1) 0))
       (f (MulAdd (RunningMin (Sub 2 (SinOsc kr 2 0)) t) 500 200)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.2))))
