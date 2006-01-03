;; (Trig in dur)

;; When `in' is trigerred output the trigger value for `dur' seconds.

(Mul (Trig ar (Dust ar 1) 0.2)
     (FSinOsc ar 800 0.5))

(Trig ar (Dust ar 4) 0.1)
