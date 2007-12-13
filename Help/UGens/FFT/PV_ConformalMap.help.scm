;; (PV_ConformalMap buffer real imag)

;; Applies the conformal mapping z -> (z-a)/(1-za*) to the phase
;; vocoder bins z with a given by the real and imag imputs to the
;; UGen.

;; See http://mathworld.wolfram.com/ConformalMapping.html

;; buffer - buffer number of buffer to act on, passed in through a chain
;; real   - real part of a.
;; imag   - imaginary part of a.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 1024 1))
   (->< fd (/b_alloc 0 2048 1))))

(audition
 (Pan2
  (IFFT*
   (PV_ConformalMap
    (FFT* 10 (Mul (audioin 1) 0.5)) (MouseX kr -1 1 0 0.1)
    (MouseY kr -1 1 0 0.1)))
  0
  1))

(let* ((signal (lambda (n)
		 (let* ((o (SinOsc kr (make-mce (randl n 0.1 0.5)) 0))
			(a (Mul (Mce 1 1.1 1.5 1.78 2.45 6.7) 220))
			(f (MulAdd o 10 a)))
		   (mix (Mul (LFSaw ar f 0) 0.3)))))
       (mapped (lambda (n)
		 (let* ((c0 (FFT* 0 (signal n)))
			(x (MouseX kr 0.01 2.0  1.0 0.1))
			(y (MouseY kr 0.01 10.0 1.0 0.1))
			(c1 (PV_ConformalMap c0 x y)))
		   (IFFT* c1))))
       (s (mapped 3))
       (t (MulAdd (CombN s 0.1 0.1 10) 0.5 s)))
  (audition (Out 0 (Pan2 t 0 1))))
