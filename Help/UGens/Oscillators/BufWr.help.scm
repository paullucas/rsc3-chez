;; (BufWr rate bufnum phase loop inputs)

;; Buffer writing oscillator.  Write to a buffer at an index. See also
;; BufRd.

;; bufnum - the index of the buffer to use
;; phase  - modulateable index into the buffer (has to be audio rate).
;; loop   - 1 means true, 0 means false.  this is modulateable.
;; input  - input ugens (channelArray)

(let ((a (letc ((r 1))
	   (let* ((r* (Mul (BufRateScale kr 0) r))
		  (p (Phasor ar 0 r* 0 (BufFrames kr 0) 0))
		  (f (MulAdd (LFNoise1 kr 2) 300 400))
		  (i (Mul (SinOsc ar f 0) 0.1)))
	     (Mrg (BufWr 0 p 1 i)
		  (Out 0 0.0)))))
      (b (letc ((r 1))
	   (let* ((r* (Mul (BufRateScale kr 0) r))
		  (p (Phasor ar 0 r* 0 (BufFrames kr 0) 0)))
	     (Out 0 (BufRd 1 ar 0 p 1 2))))))
  (with-sc3 
   (lambda (fd)
     (async fd (/b_alloc 0 (* 44100 2) 1))
     (send-synth fd "a" a)
     (send-synth fd "b" b)
     (send fd (/s_new "a" 1001 1 0))
     (send fd (/s_new "b" 1002 1 0)))))

(define (do-send m)
  (with-sc3 (lambda (fd) (send fd m))))

(do-send (/n_set 1002 "r" 5))

(do-send (/n_set 1001 "r" (rand 0 2)))

(do-send (/n_set 1002 "r" 2))
