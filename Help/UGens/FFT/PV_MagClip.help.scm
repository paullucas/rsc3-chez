;; (PV_MagClip buffer threshold)

;; Clip bins to a threshold.  Clips bin magnitudes to a maximum
;; threshold.

;; buffer    - fft buffer.
;; threshold - magnitude threshold.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))
   (->< fd (/b_allocRead 12 "/home/rohan/audio/metal.wav" 0 0))))

(let* ((a (PlayBuf 1 12 (BufRateScale kr 12) 0 0 1))
       (f (FFT* 10 a))
       (h (PV_MagClip f (MouseX kr 0 5 0 0.1))))
  (audition (Out 0 (Mul (IFFT* h) 0.5))))
