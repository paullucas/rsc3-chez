;; lfo modulation (jmcc)

(let* ((o (mul-add (fsin-osc kr 0.05 0) 80 160))
       (p (mul-add (fsin-osc kr (mce2 0.6 0.7) 0) 3600 4000))
       (s (rlpf (mul (lfpulse ar o 0 0.4) 0.05) p 0.2)))
  (audition (out 0 (comb-l s 0.3 (mce2 0.2 0.25) 2))))
