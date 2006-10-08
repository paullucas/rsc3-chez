;; (FBSineC freq im fb a c xi yi)

;; Feedback sine with chaotic phase indexing.

;; freq - iteration frequency in Hz    - 22050
;; im   - index multiplier amount      - 1
;; fb   - feedback amount              - 0.1
;; a    - phase multiplier amount      - 1.1
;; c    - phase increment amount       - 0.5
;; xi   - initial value of x           - 0.1
;; yi   - initial value of y           - 0.1

;; A cubic-interpolating sound generator based on the difference
;; equations:
	
;; 	xn+1 = sin(im*yn + fb*xn)
;; 	yn+1 = (ayn + c) % 2pi

;; This uses a linear congruential function to drive the phase
;; indexing of a sine wave.  For im = 1, fb = 0, and a = 1 a normal
;; sinewave results.

;; sclang default values

(Mul (FBSineC ar (FDiv (SampleRate ir) 4) 1 0.1 1.1 0.5 0.1 0.1) 0.2)

;; increase feedback

(let ((fb (Line kr 0.01 4 10 doNothing)))
  (Mul (FBSineC ar (SampleRate ir) 1 fb 1.1 0.5 0.1 0.1) 0.2))

;; increase phase multiplier

(let ((a (Line kr 1 2 10 doNothing)))
  (Mul (FBSineC ar (SampleRate ir) 1 0 a 0.5 0.1 0.1) 0.2))

;; randomly modulate parameters

(let* ((x (MouseX kr 1 12 0 0.1))
       (f (lambda (m a) (MulAdd (LFNoise2 kr x) m a))))
  (Mul (FBSineC ar
		(f 1e4 1e4)
		(f 32 33)
		(f 0.5 0)
		(f 0.05 1.05)
		(f 0.3 0.3)
		0.1
		0.1)
       0.2))
