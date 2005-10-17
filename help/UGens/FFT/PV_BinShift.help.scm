;;; (PV_BinShift buffer stretch shift)

;;; Shifts the leftmost bin at `buffer' by `shift' places, the
;;; distance between subsequent bins is `stretch'.

(define b (buffer-alloc (current-server) 2048 1 #t))

(Mul (IFFT.ar 
      (PV_BinShift.kr 
       (FFT.kr (buffer-id b) 
	       (SinOsc.ar (SinOsc.kr (Squared (SinOsc.kr 0.08 0 6 6.2)) 0 100 800))) 
       (MouseY.kr 1 4)
       (MouseX.kr -10 100)))
     1/2)

(buffer-free b)
