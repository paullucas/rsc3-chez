;; (Ring3 a b)

;; Ring modulation variant.  Return the value of (a * a * b). This is
;; more efficient than using separate unit generators for the
;; multiplies.

;; See also Mul, Ring1, Ring2, Ring4.

(Mul (Ring3 (FSinOsc ar 800 0)
	    (FSinOsc ar (XLine kr 200 500 5 0) 0))
     0.125)

(let ((a (FSinOsc ar 800 0))
      (b (FSinOsc ar (XLine kr 200 500 5 0) 0)))
  (Mul* a a b 0.125))
