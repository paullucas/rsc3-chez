;; (PV_PhaseShift90 buffer)

;; Swap the real and imaginary components of every bin at `buffer' and
;; swap the of the imaginary components.

(define b 0)
(-><! s (/b_alloc b 2048 1))

(IFFT.ar (PV_PhaseShift90.kr (FFT.kr b (WhiteNoise.ar 0.1))))
