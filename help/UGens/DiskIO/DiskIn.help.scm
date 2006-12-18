;; (DiskIn numChannels bufnum)

;; Continously play a soundfile from disk. This requires a buffer to
;; be preloaded with one buffer size of sound.  The buffer size must
;; be a multiple of twice the synth block size. The default block size
;; is 64.

;; Note that DiskIn reads the number of outputs to create from what
;; looks like an input, but it is not an input, and cannot be set
;; using a control.

(let ((f "/home/rohan/uc/uc-26/daily-practice/2006-10-04.wav")
      (n 2))
  (->< s (/b_alloc 0 8192 n))
  (->< s (/b_read 0 f 0 -1 0 1))
  (play s (DiskIn n ar 0)))

(reset s)

(begin (->< s (/b_close 0))
       (->< s (/b_free 0)))
