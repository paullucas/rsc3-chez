;; (pv-rand-wipe bufferA bufferB wipe trig)

;; Cross fades between two sounds by copying bins in a random order.

;; bufferA = fft buffer A.  bufferB = fft buffer B.  wipe = copies
;; bins from bufferB in a random order (0, 1).  trig = select new
;; random ordering.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))
   (->< fd (/b_alloc 11 2048 1))))

(let-syntax ((n-of (syntax-rules () 
		     ((_ n f) (mix/fill n (lambda (_) f))))))
  (let* ((n 6)
	 (a (n-of n (mul (lfsaw ar (randx 400.0 1000.0) 0.0) 0.1)))
	 (b (n-of n (mul (lfpulse ar (randx 80.0 400.0) 0.0 0.2)
			 (Max (mul (sin-osc kr (rand 0.0 8.0) 0.0) 0.2) 0.0))))
	 (f (fft* 10 a))
	 (g (fft* 11 b))
	 (h (pv-rand-wipe f g (mouse-x kr 0 1 0 0.1) (GT (mouse-y kr 0 1 0 0.1) 0.5)))
	 (i (Ifft* h)))
    (audition (out 0 (mul 0.5 (Mce i i))))))
