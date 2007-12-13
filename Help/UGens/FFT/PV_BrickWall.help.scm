;; (PV_BrickWall buffer wipe)

;; Clears bins above or below a cutoff point.  `wipe' = a unit signal,
;; from -1 to 0 the UGen acts as a low-pass filter, from 0 to 1 it
;; acts as a high pass filter.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))))

(let ((x (MouseX kr -1 1 0 0.1))
      (c (FFT* 10 (Mul (WhiteNoise ar) 0.2))))
  (audition (Out 0 (IFFT* (PV_BrickWall c x)))))
