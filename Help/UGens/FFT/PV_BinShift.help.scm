;; (PV_BinShift buffer stretch shift)

;; Shift and scale the positions of the bins.  Can be used as a very
;; crude frequency shifter/scaler.  Shifts the leftmost bin at
;; `buffer' by `shift' places, the distance between subsequent bins is
;; `stretch'.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))))

(define snd
  (let* ((f1 (Squared (MulAdd (SinOsc kr 0.08 0) 6 6.2)))
	 (f2 (SinOsc kr f1 0)))
    (SinOsc ar (MulAdd f2 100 800) 0)))

(audition
 (Mul
  (IFFT*
   (PV_BinShift
    (FFT* 10 snd)
    (MouseY kr 1 4 0 0.1)
    (MouseX kr -10 100 0 0.1)))
  1/2))
