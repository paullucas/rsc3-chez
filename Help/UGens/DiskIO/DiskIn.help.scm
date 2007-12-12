;; (DiskIn numChannels rate bufnum)

;; Continously play a soundfile from disk. This requires a buffer to
;; be preloaded with one buffer size of sound.  The buffer size must
;; be a multiple of twice the synth block size. The default block size
;; is 64.

;; Note that DiskIn reads the number of outputs to create from what
;; looks like an input, but it is not an input, and cannot be set
;; using a control.

(let ((f "/home/rohan/audio/metal.wav")
      (n 1))
  (with-sc3
   (lambda (fd)
     (->< fd (/b_alloc 0 8192 n))
     (->< fd (/b_read 0 f 0 -1 0 1))
     (play fd (Out 0 (DiskIn n ar 0))))))

(with-sc3 reset)

(with-sc3
 (lambda (fd)
   (->< fd (/b_close 0))
   (->< fd (/b_free 0))))
