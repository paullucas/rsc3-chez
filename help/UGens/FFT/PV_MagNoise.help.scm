;; (PV_MagNoise buffer)

;; Magnitudes are multiplied with noise.

;; buffer - fft buffer.

(begin
  (->< s (/b_alloc 10 2048 1))
  (->< s (/b_allocRead 12 "/home/rohan/sw/sw-01/audio/metal.wav" 0 0)))

(let* ((a (PlayBuf 1 ar 12 (BufRateScale kr 12) 0 0 1))
       (f (FFT 10 a))
       (h (PV_MagNoise f)))
  (Out 0 (Mul (IFFT h) 0.5)))
