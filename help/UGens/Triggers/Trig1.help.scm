;;; (Trig1 in dur)

;;; When `in' is trigerred output a unit signal for `dur' seconds.

(Mul (Trig1.ar (Dust.ar 1) 0.2) 
     (FSinOsc.ar 800 0 0.2))
