;; (PV_PhaseShift270 buffer)

;; Swap the real and imaginary components of every bin at `buffer' and
;; swap the sign of the real components.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))))

(let ((n (Mul (WhiteNoise ar) 0.1)))
  (audition (Out 0 (IFFT* (PV_PhaseShift270 (FFT* 10 n))))))
