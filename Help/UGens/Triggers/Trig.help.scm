;; (Trig in dur)

;; When `in' is trigerred output the trigger value for `dur' seconds.

(Mul (Trig (Dust ar 1) 0.2)
     (Mul (FSinOsc ar 800 0) 0.5))

(Trig (Dust ar 4) 0.1)
