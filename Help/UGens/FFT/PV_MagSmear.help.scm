;; (PV_MagSmear buffer bins)

;; Average a bin's magnitude with its neighbors. 

;; buffer - fft buffer.

;; bins   - number of bins to average on each side of bin. 
;;          As this number rises, so will CPU usage.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))
   (->< fd (/b_allocRead 12 "/home/rohan/audio/metal.wav" 0 0))))

(let* ((dup (lambda (a) (Mce a a)))
       (in (Mul (LFSaw ar 500 0) (Decay2 (Mul (Impulse ar 2 0) 0.2) 0.01 2)))
       (c0 (FFT* 10 in))
       (c1 (PV_MagSmear c0 (MouseX kr 0 100 0 0.1))))
  (audition (Out 0 (Mul 0.5 (dup (IFFT* c1))))))

(let* ((dup (lambda (a) (Mce a a)))
       (s (PlayBuf 1 12 (BufRateScale kr 12) 1 0 1))
       (x (MouseX kr 0 100 0 0.1)))
  (audition (Out 0 (Mul 0.5 (dup (IFFT* (PV_MagSmear (FFT* 10 s) x)))))))
