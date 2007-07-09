;; (CuspN rate freq a b xi)
;; (CuspL rate freq a b xi)

;; freq - iteration frequency in Hertz
;; a, b - equation variables
;; xi   - initial value of x

;; Cusp map chaotic generator.  Non- and linear- interpolating sound
;; generator based on the difference equation:

;; xn+1 = a - b*sqrt(|xn|)

(define Cusp_ CuspL)

;; vary frequency

(Mul (Cusp_ ar (MouseX kr 20 SampleRate 0 0.1) 1.0 1.99 0)
     0.3)

;; mouse-controlled params

(Mul (Cusp_ ar (FDiv SampleRate 4)
	       (MouseX kr 0.9 1.1 1 0.1)
	       (MouseY kr 1.8 2 1 0.1)
	       0)
     0.3)

;; as a frequency control

(Mul (SinOsc ar (MulAdd (Cusp_ ar 40
			       (MouseX kr 0.9 1.1 1 0.1)
			       (MouseY kr 1.8 2 1 0.1)
			       0)
			800 900)
	     0.0)
     0.4)
