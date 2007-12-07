;; (Gate in trig)

;; The signal at `in' is passed while `trig' is greater than zero.

(let ((s (Mul (FSinOsc ar 500 0) 1/4))
      (t (LFPulse ar 1 0 1/10)))
  (audition (Out 0 (Gate s t))))
