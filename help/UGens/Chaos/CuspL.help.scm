;; (CuspL freq a b xi)

;; freq - iteration frequency in Hertz
;; a, b - equation variables
;; xi   - initial value of x

;; Cusp map chaotic generator.  A linear-interpolating sound generator
;; based on the difference equation:

;; xn+1 = a - b*sqrt(|xn|)

;; vary frequency
(Mul (CuspL ar (MouseX kr 20 (SampleRate ir)) 1.0 1.99) 0.3)

;; mouse-controlled params
(Mul (CuspL ar (FDiv ir (SampleRate ir) 4) 
	       (MouseX kr 0.9 1.1 1)
	       (MouseY kr 1.8 2 1))
     0.3)

;; as a frequency control
(SinOsc ar (MulAdd (CuspL ar 40 
			     (MouseX kr 0.9 1.1 1)
			     (MouseY kr 1.8 2 1))
		   800 900)
	   0.0 0.4)
