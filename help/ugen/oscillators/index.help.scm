;; (index bufnum in)

;; index into a table with a signal.  The input signal value is
;; truncated to an integer value and used as an index into the table.
;; out of range index values are clipped to the valid range.

;; Allocate and set values at buffer 10.

(with-sc3 
 (lambda (fd)
   (async fd (b-alloc 10 6 1))
   (send fd (b-setn1 10 0 (list 50 100 200 400 800 1600)))))

;; index into the above buffer for frequency values.

(let ((f (mul (index 10 (Mul (lfsaw kr 2 3) 4)) (Mce 1 9))))
  (audition (out 0 (mul (sin-osc ar f 0) 0.1))))

(with-sc3 
 (lambda (fd)
   (async fd (/b_free 10))))
