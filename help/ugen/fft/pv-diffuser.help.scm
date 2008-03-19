;; (pv-diffuser buffer trig)

;; adds a different constant random phase shift to each bin.
;; The trigger will select a new set of random phases.

;; buffer - fft buffer.
;; trig - a trigger selects a new set of random values.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))
   (->< fd (/b_allocRead 12 "/home/rohan/audio/metal.wav" 0 0))))

(let* ((a (play-buf 1 12 (buf-rate-scale kr 12) 0 0 1))
       (f (fft* 10 a))
       (h (pv-diffuser f (GT (mouse-x kr 0 1 0 0.1) 0.5))))
  (audition (out 0 (mul (Ifft* h) 0.5))))
