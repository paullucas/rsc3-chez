;; (PV_MagAbove buffer threshold)

;; Pass only bands where the magnitude is above `threshold'.  This
;; value is not normalized and is therefore dependant on the buffer
;; size.

(define n 2048)
(define b 0)
(-><! s (/b_alloc b n 1))

(define signal
  (SinOsc ar (SinOsc kr (Squared (SinOsc kr 0.08 0 6 6.2)) 0 100 800)))

(Mul ar
 (IFFT ar 
  (PV_MagAbove kr 
   (FFT kr b signal) 
   (MouseX kr 1 (/ n 2))))
 0.5)
