;; (PV_PhaseShift270 buffer)

;; Swap the real and imaginary components of every bin at `buffer' and
;; swap the sign of the real components.

(define b 0)
(-><! s (/b_alloc b 2048 1))

(IFFT ar (PV_PhaseShift270 kr (FFT kr b (WhiteNoise ar 0.1))))
