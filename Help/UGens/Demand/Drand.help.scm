;; (Drand  length array)
;; (Dxrand length array)

;; Demand rate random sequence generators.

;; length	number of values to return
;; array	array of values or other ugens

;; Dxrand never plays the same value twice, whereas Drand chooses any
;; value in the list.

(let ((f (lambda (u)
	   (let* ((a (u dinf (make-mce (list 1 3 2 7 8))))
		  (t (Impulse kr (MouseX kr 1 400 1 0.1) 0))
		  (f (MulAdd (Demand t 0 a) 30 340)))
	     (Mul (SinOsc ar f 0) 0.1)))))
  (audition (Out 0 (mce2 (f Drand)
			 (f Dxrand)))))
