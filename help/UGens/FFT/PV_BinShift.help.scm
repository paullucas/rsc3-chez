;; (PV_BinShift buffer stretch shift)

;; Shifts the leftmost bin at `buffer' by `shift' places, the distance
;; between subsequent bins is `stretch'.

(define b 0)
(-><! s (/b_alloc b 2048 1))

(Mul
 (IFFT 
  (PV_BinShift 
   (FFT b (SinOsc ar (*+u (SinOsc kr (Squared (*+u (SinOsc kr 0.08 0) 6 6.2)) 0)
			  100 800) 0)) 
   (MouseY kr 1 4 0 0.1)
   (MouseX kr -10 100 0 0.1)))
 1/2)

(-><! s (/b_free b))
