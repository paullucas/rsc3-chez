;; (PulseCount trig reset)

;; This outputs the number of pulses received at `trig' and outputs
;; that value until `reset' is triggered.

(Mul (SinOsc ar (Mul (PulseCount (Impulse ar 10 0) (Impulse ar 0.4 0)) 200) 0)
     0.05)
