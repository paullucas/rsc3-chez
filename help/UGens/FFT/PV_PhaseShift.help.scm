;; (PV_PhaseShift buffer shift)

;; Add `shift' to the phase component of every bin at `buffer'.

(define b 0)

(->< s (/b_alloc b 2048 1))

(IFFT (PV_PhaseShift (FFT b (Mul (WhiteNoise ar) 0.1))
		     (MouseX kr 0 1 0 0.1)))
