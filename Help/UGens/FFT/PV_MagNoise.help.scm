;; (PV_MagNoise buffer)

;; Magnitudes are multiplied with noise.

;; buffer - fft buffer.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))
   (->< fd (/b_allocRead 12 "/home/rohan/audio/metal.wav" 0 0))))

(let* ((a (PlayBuf 1 12 (BufRateScale kr 12) 0 0 1))
       (f (FFT* 10 a))
       (h (PV_MagNoise f)))
  (audition (Out 0 (Mul (IFFT* h) 0.5))))
