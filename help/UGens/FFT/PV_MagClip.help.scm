;; (PV_MagClip buffer threshold)

;; Clips bin magnitudes to a maximum threshold.

;; buffer - fft buffer.
;; threshold - magnitude threshold.

(begin
  (->< s (/b_alloc 10 2048 1))
  (->< s (/b_allocRead 12 "/home/rohan/sw/sw-01/audio/metal.wav" 0 0)))

(let* ((a (PlayBuf ar 1 12 (BufRateScale kr 12) 0 0 1))
       (f (FFT 10 a))
       (h (PV_MagClip f (MouseX kr 0 5 0 0.1))))
  (Out 0 (Mul (IFFT h) 0.5)))
