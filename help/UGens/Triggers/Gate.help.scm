;; (Gate in trig)

;; The signal at `in' is passed while `trig' is greater than zero.

(Gate (Mul (FSinOsc ar 500 0) 1/4)
      (LFPulse ar 1 0 1/10))

