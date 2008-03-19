;; (ring3 a b)

;; Ring modulation variant.  Return the value of (a * a * b). This is
;; more efficient than using separate unit generators for the
;; multiplies.

;; See also mul, ring1, ring2, ring4.

(audition
 (out 0 (mul (ring3 (fsin-osc ar 800 0)
		    (fsin-osc ar (xline kr 200 500 5 do-nothing) 0))
	     0.125)))

(let ((a (fsin-osc ar 800 0))
      (b (fsin-osc ar (xline kr 200 500 5 do-nothing) 0)))
  (audition
   (out 0 (mul4 a a b 0.125))))
