;; (Trig in dur)

;; When `in' is trigerred output the trigger value for `dur' seconds.

(Mul (Trig (Dust 0 ar 1) 0.2)
     (Mul (FSinOsc ar 800 0) 0.5))

(Trig (Dust 0 ar 4) 0.1)
