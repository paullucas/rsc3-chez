;; (PV_RandComb buffer wipe trig)

;; Randomly clear bins.

;; buffer = fft buffer.  wipe = clear bins from input in a random
;; order (0, 1).  trig = select new random ordering.

(define b 0)

(-><! s (/b_alloc b 2048 1))

(define (Dup a) (Mce a a))

(Dup
 (IFFT (PV_RandComb (FFT b (Mul (WhiteNoise 0 ar) 0.5))
		    (MouseX kr 0.6 0.95 0 0.1)
		    (Impulse kr 0.4 0))))
