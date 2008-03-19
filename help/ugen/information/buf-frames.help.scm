;; (buf-frames rate bufnum)

;; Current duration of buffer.

(->< s (/b_allocRead 0 "/home/rohan/sw/sw-01/audio/metal.wav" 0 0))

(let ((p (phasor ar 0 (buf-rate-scale kr 0) 0 (buf-frames kr 0) 0)))
  (buf-rd 1 ar 0 p 0 2))

(let ((p (k2a (mouse-x kr 0 (buf-frames kr 0) 0 0.1))))
  (buf-rd 1 ar 0 p 0 2))
