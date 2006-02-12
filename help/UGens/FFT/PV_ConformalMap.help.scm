;; (PV_ConformalMap buffer real imag)

;; Applies the conformal mapping z -> (z-a)/(1-za*) to the phase
;; vocoder bins z with a given by the real and imag imputs to the
;; UGen.

;; See http://mathworld.wolfram.com/ConformalMapping.html

;; buffer - buffer number of buffer to act on, passed in through a chain
;; real   - real part of a.
;; imag   - imaginary part of a.


(define b 0)

(->< s (/b_alloc b 1024 1))

(Pan2 
 (IFFT 
  (PV_ConformalMap 
   (FFT b (Mul (In ar (NumInputBuses ir) 1) 0.5)) (MouseX kr -1 1 0 0.1) 
   (MouseY kr -1 1 0 0.1)))
 0
 1)
