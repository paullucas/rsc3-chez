;; (PulseCount trig reset)

;; This outputs the number of pulses received at `trig' and outputs
;; that value until `reset' is triggered.

(SinOsc ar (Mul (PulseCount ar (Impulse ar 10) (Impulse ar 0.4)) 200) 0 0.05)
