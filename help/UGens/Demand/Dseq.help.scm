;; (Dseq length array)

;; Demand rate sequence generator.

;; array	array of values or other ugens
;; length	number of repeats
		
(let* ((a (Dseq 3 (Mce 1 3 2 7 8)))
       (trig (Impulse kr (MouseX kr 1 40 1 0.1) 0))
       (freq (MulAdd (Demand trig 0 a) 30 340)))
  (Mul (SinOsc ar freq 0) 0.1))

(let* ((a (Dseq inf (make-mce (randl! 32 0 10))))
       (trig (Impulse ar (MouseX kr 1 10000 1 0.1) 0))
       (freq (MulAdd (Demand trig 0 a) 30 340)))
  (Mul (SinOsc ar freq 0) 0.1))
