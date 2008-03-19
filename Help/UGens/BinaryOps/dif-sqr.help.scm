;; (DifSqr a b)

;; Difference of squares.  Return the value of (a*a) - (b*b). This is
;; more efficient than using separate unit generators for each
;; operation.

(mul (DifSqr (fsin-osc ar 800 0)
	     (fsin-osc ar (xline kr 200 500 5 do-nothing) 0))
     0.125)

(let ((a (fsin-osc ar 800 0))
      (b (fsin-osc ar (xline kr 200 500 5 do-nothing) 0)))
  (mul (sub (Mul a a) (Mul b b)) 0.125))
