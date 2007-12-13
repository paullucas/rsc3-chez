;; (PV_MagAbove buffer threshold)

;; Pass only bands where the magnitude is above `threshold'.  This
;; value is not normalized and is therefore dependant on the buffer
;; size.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))
   (->< fd (/b_alloc 11 2048 1))
   (->< fd (/b_allocRead 12 "/home/rohan/audio/metal.wav" 0 0))))

(let* ((a (PlayBuf 1 12 (BufRateScale kr 12) 0 0 1))
       (x (MouseX kr 1 100 0 0.1))
       (y (MouseY kr 0 1 0 0.1))
       (c1 (FFT* 10 a))
       (c2 (PV_Copy c1 11))
       (c3 (PV_MagBelow c1 x))
       (c4 (PV_MagAbove c2 x)))
  (audition (Out 0 (Mul (Mce (IFFT* c3) (IFFT* c4)) (Mce y (Sub 1 y))))))

(let* ((f1 (Squared (MulAdd (SinOsc kr 0.08 0) 6 6.2)))
       (f2 (MulAdd (SinOsc kr f1 0) 100 800))
       (s (SinOsc ar f2 0))
       (x (MouseX kr 1 1024 0 0.1))
       (y (MouseY kr 0 1 0 0.1))
       (c1 (FFT* 10 s))
       (c2 (PV_Copy c1 11))
       (c3 (PV_MagBelow c1 x))
       (c4 (PV_MagAbove c2 x)))
  (audition (Out 0 (Mul (Mce (IFFT* c3) (IFFT* c4)) (Mce y (Sub 1 y))))))
