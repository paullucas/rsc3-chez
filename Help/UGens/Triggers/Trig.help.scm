;; (Trig in dur)

;; When `in' is trigerred output the trigger value for `dur' seconds.

(let ((s (FSinOsc ar 800 0))
      (g (Trig (Dust ar 1) 0.2)))
  (audition (Out 0 (Mul* s g 0.5))))

(audition (Out 0 (Trig (Dust ar 4) 0.1)))
