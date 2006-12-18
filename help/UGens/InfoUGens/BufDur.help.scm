;; (BufDur rate bufnum)

;; Current duration of buffer.

(->< s (/b_allocRead 0 "/home/rohan/sw/sw-01/audio/metal.wav" 0 0))

(let* ((t (Impulse ar (Recip (BufDur kr 0)) 0))
       (p (Sweep t (BufSampleRate kr 0))))
  (BufRd 1 ar 0 p 0 2))

