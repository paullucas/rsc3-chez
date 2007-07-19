;; (MostChange a b)

;; Output the input that changed most.

(Mul (SinOsc ar (MostChange (MulAdd (LFNoise0 kr 1) 400 900)
			    (MouseX kr 200 300 0 0.1))
	     0)
     0.1)
