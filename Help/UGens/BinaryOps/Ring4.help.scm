;; (Ring4 a b)

;; Ring modulation variant.  Return the value of ((a*a *b) -
;; (a*b*b)). This is more efficient than using separate unit
;; generators for the multiplies.

;; See also mul, Ring1, Ring2, Ring3.

(mul (Ring4 (fsin-osc ar 800 0)
	    (fsin-osc ar (xline kr 200 500 5 do-nothing) 0))
     0.125)

(let ((a (fsin-osc ar 800 0))
      (b (fsin-osc ar (xline kr 200 500 5 do-nothing) 0)))
  (mul (sub (Mul* a a b) (Mul* a b b)) 
       0.125))
