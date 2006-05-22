;; (PV_RandWipe bufferA bufferB wipe trig)

;; Cross fades between two sounds by copying bins in a random order.

;; bufferA = fft buffer A.  bufferB = fft buffer B.  wipe = copies
;; bins from bufferB in a random order (0, 1).  trig = select new
;; random ordering.

(begin 
  (->< s (/b_alloc 10 2048 1))
  (->< s (/b_alloc 11 2048 1)))

(let* ((a (mix/fill 6 (lambda (n) (Mul (LFSaw ar (randx 400.0 1000.0) 0.0) 0.1))))
       (b (mix/fill 6 (lambda (n) (Mul (LFPulse ar (randx 80.0 400.0) 0.0 0.2)
				       (Max (Mul (SinOsc kr (rand 0.0 8.0) 0.0) 0.2) 0.0)))))
       (f (FFT 10 a))
       (g (FFT 11 b))
       (h (PV_RandWipe f g (MouseX kr 0 1 0 0.1) (GT (MouseY kr 0 1 0 0.1) 0.5)))
       (i (IFFT h)))
  (Out 0 (Mul 0.5 (Mce i i))))
