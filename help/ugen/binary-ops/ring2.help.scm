;; (ring2 a b)

;; Ring modulation plus both sources.  Return the value of ((a*b) + a
;; + b). This is more efficient than using separate unit generators
;; for the multiply and add.

;; See also mul, Ring1, Ring3, Ring4.

(audition
 (out 0 (mul (ring2 (fsin-osc ar 800 0)
		    (fsin-osc ar (xline kr 200 500 5 do-nothing) 0))
	     0.125)))

(let ((a (fsin-osc ar 800 0))
      (b (fsin-osc ar (xline kr 200 500 5 do-nothing) 0)))
  (audition
   (out 0 (mul (add3 (mul a b) a b) 0.125))))
