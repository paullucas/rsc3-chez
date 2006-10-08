;; (DegreeToKey bufnum in octave)

;; Convert signal to modal pitch

;; The input signal value is truncated to an integer value and used as
;; an index into an octave repeating table of note values. Indices
;; wrap around the table and shift octaves as they do.

;; bufnum - index of the buffer which contains the steps for each
;;          scale degree.

;; in - the input signal.

;; octave - the number of steps per octave in the scale.

(->< s (/b_alloc 0 7 1))

(-> s (/b_setn* 0 0 (list 0 2 3.2 5 7 9 10)))

(let* ((k (DegreeToKey 0 (MouseX kr 0 15 0 0.1) 12))
       (n (Mul (LFNoise1 kr (Mce 3 3)) 0.04))
       (f (lambda (b)
	    (let* ((o (Mul (SinOsc ar (MIDICPS (Add* b k n)) 0) 0.1))
		   (d (Mul (RLPF (LFPulse ar (MIDICPS (Mce 48 55)) 0.15 0.5)
				 (MIDICPS (MulAdd (SinOsc kr 0.1 0) 10 b))
				 0.1)
			   0.1))
		   (m (Add o d)))
	      (Add (CombN m 0.31 0.31 2) m)))))
  (Mul (Add (f 48) (f 72)) 0.5))
