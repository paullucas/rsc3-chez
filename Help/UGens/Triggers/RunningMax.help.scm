;; (RunningMax in trig)

;; Track maximum level.  Outputs the maximum value received at the
;; input.  When triggered, the maximum output value is reset to the
;; current value.

;; in   - input signal
;; trig - reset the output value to the current input value

(let* ((t (Impulse ar 0.4 0))
       (f (MulAdd (RunningMax (Dust ar 20) t) 500 200)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.2))))

(let* ((t (Impulse kr (MouseX kr 0.01 2 1 0.1) 0))
       (f (MulAdd (RunningMax (SinOsc kr 2 0) t) 500 200)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.2))))
