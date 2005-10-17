;; (Peak trig reset)

;; Outputs the maximum value read at the `trig' input until `reset' is
;; triggered.

(SinOsc.ar (Add (Mul (Peak.ar (Dust.ar 20) (Impulse.ar 0.4)) 500) 200) 0 0.2)
