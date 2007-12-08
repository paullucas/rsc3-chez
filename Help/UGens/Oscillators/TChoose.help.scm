;; (TChoose trig array)

;; The output is selected randomly on recieving a trigger from an
;; array of inputs.  TChoose is a composite of TIRand and Select.

(audition
 (let* ((t (Dust ar (MouseX kr 1 1000 1 0.1)))
	(f (MIDICPS (TIRand 48 60 t)))
	(a (Mce (SinOsc ar f 0)
		(Saw ar (Mul f 2))
		(Pulse ar (Mul f 0.5) 0.1))))
   (Out 0 (Mul (TChoose t a) 0.1))))

;; Note: all the ugens are continously running. This may not be the
;; most efficient way if each input is cpu-expensive.
