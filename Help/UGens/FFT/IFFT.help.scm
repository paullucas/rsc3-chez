;; (IFFT buffer)

;; Inverse Fast Fourier Transform.  The inverse fast fourier transform
;; converts from frequency content to a signal.

(->< s (/b_alloc 0 2048 1))

(IFFT (FFT 0 (Mul (WhiteNoise ar) 0.05)))
