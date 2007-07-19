;; (BufFrames rate bufnum)

;; Current duration of buffer.

(->< s (/b_allocRead 0 "/home/rohan/sw/sw-01/audio/metal.wav" 0 0))

(let ((p (Phasor ar 0 (BufRateScale kr 0) 0 (BufFrames kr 0) 0)))
  (BufRd 1 ar 0 p 0 2))

(let ((p (K2A (MouseX kr 0 (BufFrames kr 0) 0 0.1))))
  (BufRd 1 ar 0 p 0 2))
