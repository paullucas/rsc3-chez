;; (GbmanC freq xi yi)
;; (GbmanL freq xi yi)
;; (GbmanN freq xi yi)

;; Gingerbreadman map chaotic generator.  Cubic, linear and
;; non-interpolating variants.

;; freq - iteration frequency in Hertz
;; xi   - initial value of x
;; yi   - initial value of y

;; A linear-interpolating sound generator based on the difference
;; equations:

;; 	xn+1 = 1 - yn + |xn|
;; 	yn+1 = xn

;; The behavior of the system is dependent only on its initial conditions
;; qand cannot be changed once it's started.

;; Reference: Devaney, R. L. "The Gingerbreadman." Algorithm 3, 15-16,
;; Jan. 1992.

;; sclang default initial parameters.

(Mul (GbmanL ar (MouseX kr 20 (SampleRate ir) 0 0.1) 1.2 2.1) 0.1)

;; Different initial parameters.

(Mul (GbmanL ar (MouseX kr 20 (SampleRate ir) 0 0.1) -0.7 -2.7) 0.1)

;; Wait for it...

(Mul (GbmanL ar (MouseX kr 20 (SampleRate ir) 0 0.1) 1.2 2.0002) 0.1)

;; As a frequency control

(Mul (SinOsc ar (MulAdd (GbmanL ar 40 1.2 2.1) 400 500) 0) 0.4)
