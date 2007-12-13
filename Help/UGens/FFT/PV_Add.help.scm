;; (PV_Add bufferA bufferB)

;; Complex addition: RealA + RealB, ImagA + ImagB

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))
   (->< fd (/b_alloc 11 2048 1))
   (->< fd (/b_allocRead 12 "/home/rohan/audio/metal.wav" 0 0))))

(let* ((a (PlayBuf 1 12 (BufRateScale kr 12) 0 0 1))
       (f (FFT* 10 a))
       (g (FFT* 11 (Mul (SinOsc ar 440 0) 0.2)))
       (h (PV_Add f g)))
  (audition (Out 0 (Mul (IFFT* h) 0.5))))

(audition
 (Mul (Add (PlayBuf 1 12 (BufRateScale kr 12) 0 0 1)
	   (Mul (SinOsc ar 440 0) 0.2))
      0.5))
