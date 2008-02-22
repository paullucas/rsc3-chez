;; (DegreeToKey bufnum in octave)

;; Convert signal to modal pitch

;; The input signal value is truncated to an integer value and used as
;; an index into an octave repeating table of note values. Indices
;; wrap around the table and shift octaves as they do.

;; bufnum - index of the buffer which contains the steps for each
;;          scale degree.

;; in - the input signal.

;; octave - the number of steps per octave in the scale.

(let* ((b 0)
       (p (list 0 2 3.2 5 7 9 10))
       (x (MouseX kr 0 15 0 0.1))
       (k (DegreeToKey 0 x 12))
       (c (lambda (n r)
	    (let* ((o (Mul (SinOsc ar (MIDICPS (Add* r k n)) 0) 0.1))
		   (t (LFPulse ar (MIDICPS (Mce 48 55)) 0.15 0.5))
		   (f (MIDICPS (MulAdd (SinOsc kr 0.1 0) 10 r)))
		   (d (Mul (RLPF t f 0.1) 0.1))
		   (m (Add o d)))
	      (Add (CombN m 0.31 0.31 2) m)))))
  (with-sc3
   (lambda (fd)
     (->< fd (/b_alloc 0 7 1))
     (-> fd (/b_setn* 0 0 p))
     (let ((n (Mul (LFNoise1 kr (Mce 3 3.05)) 0.04)))
       (play fd (Out 0 (Mul (Add (c n 48) (c n 72)) 0.25)))))))
