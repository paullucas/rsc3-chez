;; modal space (jmcc)

(let* ((b 0)
       (p (list 0 2 3.2 5 7 9 10))
       (x (MouseX kr 0 15 0 0.1))
       (k (DegreeToKey 0 x 12))
       (c (lambda (n r)
	    (let* ((o (Mul (SinOsc ar (MIDICPS (Add3 r k n)) 0) 0.1))
		   (t (LFPulse ar (MIDICPS (mce2 48 55)) 0.15 0.5))
		   (f (MIDICPS (MulAdd (SinOsc kr 0.1 0) 10 r)))
		   (d (Mul (RLPF t f 0.1) 0.1))
		   (m (Add o d)))
	      (Add (CombN m 0.31 0.31 2) m)))))
  (with-sc3
   (lambda (fd)
     (async fd (/b_alloc 0 7 1))
     (send fd (/b_setn1 0 0 p))
     (let ((n (Mul (LFNoise1 kr (mce2 3 3.05)) 0.04)))
       (play fd (Out 0 (Mul (Add (c n 48) (c n 72)) 0.25)))))))
