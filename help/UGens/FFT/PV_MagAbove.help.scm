;; (PV_MagAbove buffer threshold)

;; Pass only bands where the magnitude is above `threshold'.  This
;; value is not normalized and is therefore dependant on the buffer
;; size.

(begin
  (->< s (/b_alloc 10 2048 1))
  (->< s (/b_allocRead 12 (rsc-file "audio/metal.wav") 0 0)))

(let* ((a (PlayBuf ar 1 12 (BufRateScale kr 12) 0 0 1))
       (f (FFT 10 a))
       (h (PV_MagAbove f (MouseX kr 1 100 0 0.1))))
  (Out 0 (Mul (IFFT h) 0.5)))

(let* ((a (MulAdd (SinOsc kr (Squared (MulAdd (SinOsc kr 0.08 0) 6 6.2)) 0) 100 800))
       (b (SinOsc ar a 0))
       (f (FFT 10 b))
       (h (PV_MagAbove f (MouseX kr 1 (/ n 2) 0 0.1))))
  (Mul (IFFT h) 0.5))
