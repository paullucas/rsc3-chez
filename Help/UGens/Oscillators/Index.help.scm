;; (Index bufnum in)

;; Index into a table with a signal.  The input signal value is
;; truncated to an integer value and used as an index into the table.
;; Out of range index values are clipped to the valid range.

;; Allocate and set values at buffer 10.

(with-sc3 
 (lambda (fd)
   (async fd (/b_alloc 10 6 1))
   (send fd (/b_setn 10 0 6 50 100 200 400 800 1600))))

;; Index into the above buffer for frequency values.

(let ((f (Mul (Index 10 (Mul (LFSaw kr 2 3) 4)) (Mce 1 9))))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.1))))

(with-sc3 
 (lambda (fd)
   (async fd (/b_free 10))))
