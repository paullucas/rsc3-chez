;; (BufWr bufnum phase loop inputs)

;; Buffer writing oscillator.  Write to a buffer at an index. See also
;; BufRd.

;; bufnum		the index of the buffer to use
;; phase   		modulateable index into the buffer (has to be audio rate).
;; loop      		1 means true, 0 means false.  this is modulateable.
;; input 		input ugens (channelArray)

;; Note: BufWr (in difference to BufRd) does not do multichannel
;; expansion, because input is an array.

(->< s (/b_alloc 0 (* 44100 2) 1))

;; Write into the buffer with a BufWr

(send-synth
 s "a"
 (letc ((r 1))
   (let ((p (Phasor ar 0 (Mul (BufRateScale kr 0) r) 0 (BufFrames kr 0) 0))
	 (i (Mul (SinOsc ar (MulAdd (LFNoise1 kr 2) 300 400) 0) 0.1)))
     (Mrg (BufWr 0 p 1 i)
	  (Out 0 0.0)))))

(send-synth
 s "b"
 (letc ((r 1))
   (let ((p (Phasor ar 0 (Mul (BufRateScale kr 0) r) 0 (BufFrames kr 0) 0)))
     (Out 0 (BufRd 1 ar 0 p 1 2)))))

(-> s (/s_new "a" 1001 1 0))

(-> s (/s_new "b" 1002 1 0))

(-> s (/n_set 1002 "r" 5))

(-> s (/n_set 1001 "r" (rand 0 2)))

(-> s (/n_set 1002 "r" 2))







