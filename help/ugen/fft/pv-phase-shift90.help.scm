;; (pv-phase-shift90 buffer)

;; Swap the real and imaginary components of every bin at `buffer' and
;; swap the of the imaginary components.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))))

(let ((n (mul (white-noise ar) 0.1)))
  (audition (out 0 (Ifft* (pv-phase-shift90 (fft* 10 n))))))
