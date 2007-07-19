;; (PV_MagBelow buffer threshold)

;; Pass bins below a threshold.  Pass only bands where the magnitude
;; is below `threshold'.  This value is not normalized and is
;; therefore dependant on the buffer size.

(begin
  (->< s (/b_alloc 10 2048 1))
  (->< s (/b_allocRead 12 "/home/rohan/sw/sw-01/audio/metal.wav" 0 0)))

(let* ((a (PlayBuf 1 12 (BufRateScale kr 12) 0 0 1))
       (f (FFT 10 a))
       (h (PV_MagBelow f (MouseX kr 0 50 0 0.1))))
  (Out 0 (Mul (IFFT h) (MouseY kr 0 1 0 0.1))))

(let* ((a (MulAdd (SinOsc kr (Squared (MulAdd (SinOsc kr 0.08 0) 6 6.2)) 0) 100 800))
       (b (SinOsc ar a 0))
       (f (FFT 10 b))
       (h (PV_MagBelow f (MouseX kr 0 1024 0 0.1))))
  (Mul (IFFT h) 0.5))
