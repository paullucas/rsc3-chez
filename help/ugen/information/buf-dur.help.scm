;; (buf-dur rate bufnum)

;; Current duration of buffer.

(->< s (/b_allocRead 0 "/home/rohan/sw/sw-01/audio/metal.wav" 0 0))

(let* ((t (impulse ar (Recip (buf-dur kr 0)) 0))
       (p (sweep t (buf-sample-rate kr 0))))
  (buf-rd 1 ar 0 p 0 2))

