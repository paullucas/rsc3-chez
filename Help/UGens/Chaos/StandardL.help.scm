;; (StandardL rate freq k xi yi)
;; (StandardN rate freq k xi yi)

;; Standard map chaotic generator.

;; freq - iteration frequency in Hertz
;; k    - perturbation amount
;; xi   - initial value of x
;; yi   - initial value of y

;; A linear-interpolating sound generator based on the difference
;; equations:

;; 	xn+1 = (xn + yn+1) % 2pi
;; 	yn+1 = (yn + ksin(xn)) % 2pi

;; The standard map is an area preserving map of a cylinder discovered by
;; the plasma physicist Boris Chirikov.

;; Vary frequency

(Mul (StandardL ar (MouseX kr 20 SampleRate 0 0.1) 1 0.5 0) 0.3)

;; Mouse-controlled parameter.

(let ((f (FDiv SampleRate 2))
      (x (MouseX kr 0.9 4 0 0.1)))
  (Mul (StandardL ar f x 0.5 0) 0.3))

;; As a frequency control

(let* ((x (MouseX kr 0.9 4 0 0.1))
       (f (MulAdd (StandardL ar 40 x 0.5 0) 800 900)))
  (Mul (SinOsc ar f 0) 0.4))
