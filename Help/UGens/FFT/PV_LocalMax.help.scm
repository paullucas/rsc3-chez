;; (PV_LocalMax buffer threshold)

;; Pass bins which are a local maximum

;; Passes only bins whose magnitude is above a threshold and above
;; their nearest neighbors.

;; buffer - fft buffer.
;; threshold - magnitude threshold.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))
   (->< fd (/b_allocRead 12 "/home/rohan/audio/metal.wav" 0 0))))

(let* ((a (PlayBuf 1 12 (BufRateScale kr 12) 0 0 1))
       (f (FFT* 10 a))
       (h (PV_LocalMax f (MouseX kr 0 100 0 0.1))))
  (audition (Out 0 (Mul (IFFT* h) 0.5))))
