;; (PulseCount trig reset)

;; This outputs the number of pulses received at `trig' and outputs
;; that value until `reset' is triggered.

(let ((f (Mul (PulseCount (Impulse ar 10 0) (Impulse ar 0.4 0)) 200)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.05))))
