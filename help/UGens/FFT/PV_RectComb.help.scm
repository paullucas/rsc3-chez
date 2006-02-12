;; (PV_RectComb buffer numTeeth phase width)

(define b 0)

(->< s (/b_alloc b 2048 1))

(define (Dup a) (Mce a a))

(IFFT (PV_RectComb (FFT b (Dup (Mul (WhiteNoise R0 ar) 0.3)))
		   8
		   (MouseX kr 0 0.5 0 0.1)
		   (MouseY kr 0 0.5 0 0.1)))

(IFFT (PV_RectComb (FFT b (Dup (Mul (WhiteNoise R0 ar) 0.3)))
		   8
		   (MulAdd (LFTri kr 0.097 0) 0.4 0.5)
		   (MulAdd (LFTri kr 0.24 0) -0.5 0.5)))
