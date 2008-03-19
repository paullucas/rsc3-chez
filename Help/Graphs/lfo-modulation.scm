;; lfo modulation (jmcc)

(let* ((o (MulAdd (FSinOsc kr 0.05 0) 80 160))
       (p (MulAdd (FSinOsc kr (mce2 0.6 0.7) 0) 3600 4000))
       (s (RLPF (Mul (LFPulse ar o 0 0.4) 0.05) p 0.2)))
  (audition (Out 0 (CombL s 0.3 (mce2 0.2 0.25) 2))))
