;; (Trig1 in dur)

;; When `in' is trigered output a unit signal for `dur' seconds.

(Mul (Trig1 (Dust ar 1) 0.2) 
     (Mul (FSinOsc ar 800 0) 0.2))
