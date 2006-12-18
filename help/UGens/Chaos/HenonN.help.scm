;; (HenonN rate freq a b x0 x1)
;; (HenonL rate freq a b x0 x1)
;; (HenonC rate freq a b x0 x1)

;; Henon map chaotic generator.

;; freq   - iteration frequency in Hertz   -- 22050
;; a, b   - equation variables             -- 1.4, 0.3
;; x0, x1 - initial and second values of x -- 0, 0

;; A non-interpolating sound generator based on the difference
;; equation:

;;     xn + 2 = 1 - axn + 12 + bxn

;; This equation was discovered by French astronomer Michel Henon
;; while studying the orbits of stars in globular clusters.

;; With default initial parameters.

(Mul (HenonN ar (MouseX kr 20 (SampleRate ir) 0 0.1) 1.4 0.3 0 0)
     0.1)

;; With mouse-control of parameters.

(Mul (HenonN ar
	     (FDiv (SampleRate ir) 4)
	     (MouseX kr 1 1.4 0 0.1)
	     (MouseY kr 0 0.3 0 0.1)
	     0
	     0)
     0.1)

;; With randomly modulate parameters.

(Mul (HenonN ar
	     (FDiv (SampleRate ir) 8)
	     (MulAdd (LFNoise2 kr 1) 0.20 1.20)
	     (MulAdd (LFNoise2 kr 1) 0.15 0.15)
	     0
	     0)
     0.1)

;; As a frequency control.

(let ((x (MouseX kr 1 1.4 0 0.1))
      (y (MouseY kr 0 0.3 0 0.1))
      (f 40))
  (Mul (SinOsc ar (MulAdd (HenonN ar f x y 0 0) 800 900) 0)
       0.4))
