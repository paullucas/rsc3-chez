;; (Peak trig reset)

;; Outputs the maximum value read at the `trig' input until `reset' is
;; triggered.

(Mul (SinOsc ar (MulAdd (Peak (Dust ar 20) (Impulse ar 0.4 0)) 500 200) 0)
     0.2)
