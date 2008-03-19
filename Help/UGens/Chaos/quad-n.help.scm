;; (quad-n rate freq a b c xi)
;; (quad-l rate freq a b c xi)
;; (quad-c rate freq a b c xi)

;; freq - iteration frequency in Hertz
;; a, b, c - equation variables
;; xi - initial value of x

;; General quadratic map chaotic generator.  Non-, linear- and cubic-
;; interpolating sound generators based on the difference equation:
;; xn+1 = axn2 + bxn + c

(define Quad_ quad-c)

(mul (Quad_ ar 4000 1 -1 -0.75 0) 0.2)

(let ((r (mouse-x kr 3.5441 4 0 0.1)))
  (mul (Quad_ ar 4000.0 (Neg r) r 0 0.1) 0.4))

(let ((r (mouse-x kr 3.5441 4 0 0.1)))
  (mul (sin-osc ar (mul-add (Quad_ ar 4 (Neg r) r 0 0.1) 800 900) 0)
       0.4))
