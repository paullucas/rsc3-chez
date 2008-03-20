;; sprinkler (jmcc)

(let* ((f (mul-add (lfpulse kr 0.09 0 0.16) 10 7))
       (t (mul (lfpulse kr f 0 0.25) 0.1)))
  (audition (out 0 (bpz2 (mul (white-noise ar) t)))))