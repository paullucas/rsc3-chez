;; (PV_RandWipe bufferA bufferB wipe trig)

;; Cross fades between two sounds by copying bins in a random order.

;; bufferA = fft buffer A.  bufferB = fft buffer B.  wipe = copies
;; bins from bufferB in a random order (0, 1).  trig = select new
;; random ordering.

(define b0 0)
(define b1 1)

(->< s (/b_alloc b0 2048 1))
(->< s (/b_alloc b1 2048 1))

(let* ((in0 (mix/fill 
	     6 
	     (lambda (n) 
	       (Mul (LFSaw ar (randx 400.0 1000.0) 0.0) 0.1))))
       (in1 (mix/fill 
	     6 
	     (lambda (n) 
	       (Mul (LFPulse ar (randx 80.0 400.0) 0.0 0.2)
		    (Max (Mul (SinOsc kr (rand 0.0 8.0) 0.0) 0.2) 0.0)))))
       (c0 (FFT b0 in0))
       (c1 (FFT b1 in1))
       (c2 (PV_RandWipe c0 
			c1 
			(MouseX kr 0 1 0 0.1) 
			(GT (MouseY kr 0 1 0 0.1) 0.5)))
       (c3 (IFFT c2)))
  (Out 0 (Mul 0.5 (Mce c3 c3))))
