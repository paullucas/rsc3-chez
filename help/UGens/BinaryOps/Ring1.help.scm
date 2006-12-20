;; (Ring1 a b)

;; Ring modulation plus first source.  Return the value of ((a*b) +
;; a). This is more efficient than using separate unit generators for
;; the multiply and add.

;; See also Mul, Ring1, Ring2, Ring3, Ring4.

(Mul (Ring1 (FSinOsc ar 800 0)
	    (FSinOsc ar (XLine kr 200 500 5 doNothing) 0))
     0.125)

(let ((a (FSinOsc ar 800 0))
      (b (FSinOsc ar (XLine kr 200 500 5 doNothing) 0)))
  (Mul (Add (Mul a b) a) 0.125))
