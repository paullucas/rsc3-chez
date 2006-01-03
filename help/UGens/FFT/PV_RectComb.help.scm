;; (PV_RectComb buffer numTeeth phase width)

;; 

(define b 0)
(-><! s (/b_alloc b 2048 1))

(define (dup a) (list a a))

(IFFT ar (PV_RectComb kr (FFT kr b (dup (WhiteNoise ar 0.3)))
			 8
			 (MouseX kr 0 0.5)
			 (MouseY kr 0 0.5)))

(IFFT ar (PV_RectComb kr (FFT kr b (dup (WhiteNoise ar 0.3)))
			 8
			 (LFTri kr 0.097 0 0.4 0.5)
			 (LFTri kr 0.24 0 -0.5 0.5)))
