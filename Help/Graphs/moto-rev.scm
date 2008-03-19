;; moto rev (jmcc)

(let* ((f (MulAdd (SinOsc kr 0.2 0) 10 21))
       (s (LFPulse ar f (mce2 0 0.1) 0.1)))
  (audition (Out 0 (Clip2 (RLPF s 100 0.1) 0.4))))
