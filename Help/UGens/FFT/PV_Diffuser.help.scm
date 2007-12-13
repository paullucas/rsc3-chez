;; (PV_Diffuser buffer trig)

;; Adds a different constant random phase shift to each bin.
;; The trigger will select a new set of random phases.

;; buffer - fft buffer.
;; trig - a trigger selects a new set of random values.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))
   (->< fd (/b_allocRead 12 "/home/rohan/audio/metal.wav" 0 0))))

(let* ((a (PlayBuf 1 12 (BufRateScale kr 12) 0 0 1))
       (f (FFT* 10 a))
       (h (PV_Diffuser f (GT (MouseX kr 0 1 0 0.1) 0.5))))
  (audition (Out 0 (Mul (IFFT* h) 0.5))))
