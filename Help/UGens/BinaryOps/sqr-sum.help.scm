;; (SqrSum a b)

;; Square of the difference.  Return the value of (a + b)**2. This is
;; more efficient than using separate unit generators for each
;; operation.

(mul (SqrSum (fsin-osc ar 800 0)
	     (fsin-osc ar (xline kr 200 500 5 do-nothing) 0))
     0.125)

(let ((a (fsin-osc ar 800 0))
      (b (fsin-osc ar (xline kr 200 500 5 do-nothing) 0)))
  (mul (Mul (add a b) (Add a b))
       0.125))
