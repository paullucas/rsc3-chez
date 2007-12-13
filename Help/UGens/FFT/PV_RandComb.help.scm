;; (PV_RandComb buffer wipe trig)

;; Randomly clear bins.

;; buffer = fft buffer.  wipe = clear bins from input in a random
;; order (0, 1).  trig = select new random ordering.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))))

(let ((dup (lambda (a) (Mce a a)))
      (n (Mul (WhiteNoise ar) 0.5))
      (x (MouseX kr 0.6 0.95 0 0.1))
      (t (Impulse kr 0.4 0)))
  (audition (Out 0 (dup (IFFT* (PV_RandComb (FFT* 10 n) x t))))))
