;; (BufRateScale bufnum)

;; Buffer rate scaling in respect to server samplerate.  Returns a
;; ratio by which the playback of a soundfile is to be scaled.

(->< s (/b_allocRead 0 "/home/rohan/sw/sw-01/audio/metal.wav" 0 0))

(let* ((r (Mul (rand 0.5 2) (BufRateScale kr 0)))
       (p (Phasor ar 0 r 0 (BufFrames kr 0) 0)))
  (BufRd ar 1 0 p 0 2))
