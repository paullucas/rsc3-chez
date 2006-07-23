;; (RunningMax in trig)

;; Track maximum level.  Outputs the maximum value received at the
;; input.  When triggered, the maximum output value is reset to the
;; current value.

;; in   - input signal
;; trig - reset the output value to the current input value

(Mul (SinOsc ar (MulAdd (RunningMax (Dust ar 20) (Impulse ar 0.4 0)) 500 200) 0)
     0.2)

(Mul (SinOsc ar (MulAdd (RunningMax (SinOsc kr 2 0) (Impulse kr (MouseX kr 0.01 2 1 0.1) 0)) 500 200) 0)
     0.2)
