;; (Peak trig reset)

;; Outputs the maximum value read at the `trig' input until `reset' is
;; triggered.

(let* ((p (Peak (Dust ar 20) (Impulse ar 0.4 0)))
       (f (MulAdd p 500 200)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.2))))
