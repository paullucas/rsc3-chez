;; (Trig1 in dur)

;; When `in' is trigered output a unit signal for `dur' seconds.

(let ((a (Trig1 (Dust ar 1) 0.2)))
  (audition (Out 0 (Mul* (FSinOsc ar 800 0) a 0.2))))
