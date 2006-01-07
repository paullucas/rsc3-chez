;; (PV_MagAbove buffer threshold)

;; Pass only bands where the magnitude is above `threshold'.  This
;; value is not normalized and is therefore dependant on the buffer
;; size.

(define n 2048)
(define b 0)
(-><! s (/b_alloc b n 1))

(define signal
  (SinOsc ar (MulAdd (SinOsc kr (Squared (MulAdd (SinOsc kr 0.08 0) 6 6.2)) 0)
		     100 800)
	  0))

(Mul
 (IFFT 
  (PV_MagAbove 
   (FFT b signal) 
   (MouseX kr 1 (/ n 2) 0 0.1)))
 0.5)
