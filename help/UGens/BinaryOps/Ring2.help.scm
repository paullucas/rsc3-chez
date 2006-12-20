;; (Ring2 a b)

;; Ring modulation plus both sources.  Return the value of ((a*b) + a
;; + b). This is more efficient than using separate unit generators
;; for the multiply and add.

;; See also Mul, Ring1, Ring3, Ring4.

(Mul (Ring2 (FSinOsc ar 800 0)
	    (FSinOsc ar (XLine kr 200 500 5 0) 0))
     0.125)

(let ((a (FSinOsc ar 800 0))
      (b (FSinOsc ar (XLine kr 200 500 5 0) 0)))
  (Mul (Add* (Mul a b) a b) 0.125))
