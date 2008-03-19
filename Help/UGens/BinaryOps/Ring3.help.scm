;; (Ring3 a b)

;; Ring modulation variant.  Return the value of (a * a * b). This is
;; more efficient than using separate unit generators for the
;; multiplies.

;; See also mul, Ring1, Ring2, Ring4.

(mul (Ring3 (fsin-osc ar 800 0)
	    (fsin-osc ar (xline kr 200 500 5 do-nothing) 0))
     0.125)

(let ((a (fsin-osc ar 800 0))
      (b (fsin-osc ar (xline kr 200 500 5 do-nothing) 0)))
  (mul* a a b 0.125))
