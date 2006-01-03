;; (PV_RandComb buffer wipe trig)

;; Randomly clear bins.

;; buffer = fft buffer.  wipe = clear bins from input in a random
;; order (0, 1).  trig = select new random ordering.

(define b 0)
(-><! s (/b_alloc b 2048 1))

(define (dup a) (list a a))

(dup
 (IFFT ar (PV_RandComb kr (FFT kr b (WhiteNoise ar 0.8))
			  (MouseX kr 0.6 0.95)
			  (Impulse kr 0.4))))
