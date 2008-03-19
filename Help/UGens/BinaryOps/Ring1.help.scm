;; (Ring1 a b)

;; Ring modulation plus first source.  Return the value of ((a*b) +
;; a). This is more efficient than using separate unit generators for
;; the multiply and add.

;; See also mul, Ring1, Ring2, Ring3, Ring4.

(mul (Ring1 (fsin-osc ar 800 0)
	    (fsin-osc ar (xline kr 200 500 5 do-nothing) 0))
     0.125)

(let ((a (fsin-osc ar 800 0))
      (b (fsin-osc ar (xline kr 200 500 5 do-nothing) 0)))
  (mul (add (Mul a b) a) 0.125))
