;; (LinCongC rate freq a c m xi)
;; (LinCongL rate freq a c m xi)
;; (LinCongN rate freq a c m xi)

;; Linear congruential chaotic generator.

;; freq - iteration frequency in Hertz
;; a    - multiplier amount
;; c    - increment amount
;; m    - modulus amount
;; xi   - initial value of x

;; A cubic-interpolating sound generator based on the difference
;; equation:

;; 	xn+1 = (axn + c) % m

;; The output signal is automatically scaled to a range of [-1, 1].


;; Default initial parameters.

(let ((x (MouseX kr 20 SampleRate 0 0.1)))
  (Mul (LinCongC ar x 1.1 0.13 1 0) 0.2))

;; Randomly modulate parameters.

(Mul (LinCongC ar
	       (MulAdd (LFNoise2 kr 1.0) 1e4 1e4)
	       (MulAdd (LFNoise2 kr 0.1) 0.5 1.4)
	       (MulAdd (LFNoise2 kr 0.1) 0.1 0.1)
	       (LFNoise2 kr 0.1)
	       0)
     0.2)

;; As frequency control...

(Mul (SinOsc ar (MulAdd (LinCongC ar
				  40 
				  (MulAdd (LFNoise2 kr 0.1) 0.1 1.0)
				  (MulAdd (LFNoise2 kr 0.1) 0.1 0.1)
				  (LFNoise2 kr 0.1)
				  0)
			500 600) 0)
     0.4)
