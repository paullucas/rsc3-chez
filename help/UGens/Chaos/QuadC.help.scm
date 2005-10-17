;; (QuadC.ar freq a b c xi)

;; freq - iteration frequency in Hertz
;; a, b, c - equation variables
;; xi - initial value of x

;; General quadratic map chaotic generator.  A cubic-interpolating
;; sound generator based on the difference equation: xn+1 = axn2 + bxn
;; + c

;; default params
(Mul.ar (QuadC.ar 4000.0) 0.2)

(let ((r (MouseX.kr 3.5441 4)))
  (QuadC.ar 4000.0 (Neg.kr r) r 0 0.1 0.4))

;; logistic map as frequency control
(let ((r (MouseX.kr 3.5441 4)))
  (SinOsc.ar (QuadC.ar 4 (Neg.kr r) r 0 0.1 800 900) 0.0 0.4))
