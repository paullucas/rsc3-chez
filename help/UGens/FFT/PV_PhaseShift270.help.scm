;; (PV_PhaseShift270 buffer)

;; Swap the real and imaginary components of every bin at `buffer' and
;; swap the sign of the real components.

(define b 0)

(->< s (/b_alloc b 2048 1))

(IFFT (PV_PhaseShift270 (FFT b (Mul (WhiteNoise R0 ar) 0.1))))
