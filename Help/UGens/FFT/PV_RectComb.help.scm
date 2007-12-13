;; (PV_RectComb buffer numTeeth phase width)

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))))

(let* ((dup (lambda (a) (Mce a a)))
       (x (MouseX kr 0 0.5 0 0.1))
       (y (MouseY kr 0 0.5 0 0.1))
       (n (dup (Mul (WhiteNoise ar) 0.3)))
       (c (PV_RectComb (FFT* 10 n) 8 x y)))
  (audition (Out 0 (IFFT* c))))

(let* ((dup (lambda (a) (Mce a a)))
       (p (MulAdd (LFTri kr 0.097 0) 0.4 0.5))
       (w (MulAdd (LFTri kr 0.24 0) -0.5 0.5))
       (n (dup (Mul (WhiteNoise ar) 0.3)))
       (c (PV_RectComb (FFT* 10 n) 8 p w)))
  (audition (Out 0 (IFFT* c))))
