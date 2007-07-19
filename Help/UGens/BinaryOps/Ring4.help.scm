;; (Ring4 a b)

;; Ring modulation variant.  Return the value of ((a*a *b) -
;; (a*b*b)). This is more efficient than using separate unit
;; generators for the multiplies.

;; See also Mul, Ring1, Ring2, Ring3.

(Mul (Ring4 (FSinOsc ar 800 0)
	    (FSinOsc ar (XLine kr 200 500 5 doNothing) 0))
     0.125)

(let ((a (FSinOsc ar 800 0))
      (b (FSinOsc ar (XLine kr 200 500 5 doNothing) 0)))
  (Mul (Sub (Mul* a a b) (Mul* a b b)) 
       0.125))
