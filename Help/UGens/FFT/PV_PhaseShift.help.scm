;; (PV_PhaseShift buffer shift)

;; Add `shift' to the phase component of every bin at `buffer'.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))))

(let ((n (Mul (WhiteNoise ar) 0.1))
      (x (MouseX kr 0 1 0 0.1)))
  (audition (Out 0 (IFFT* (PV_PhaseShift (FFT* 10 n) x)))))
