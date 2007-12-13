;; (IFFT buffer wintype)
;; (IFFT* b) => (IFFT b 0) 

;; Inverse Fast Fourier Transform.  The inverse fast fourier transform
;; converts from frequency content to a signal.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 0 2048 1))))

(let* ((s (Mul (WhiteNoise ar) 0.05))
       (c (FFT 0 s 0.5 0 1)))
  (audition (Out 0 (IFFT c 0))))
