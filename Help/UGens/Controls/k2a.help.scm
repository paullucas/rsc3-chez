;; (k2a in)

;; Control rate to audio rate converter.

;; To be able to play a control rate UGen into an audio rate UGen,
;; sometimes the rate must be converted.  k2a converts via linear
;; interpolation.

;; in - input signal

(k2a (mul (white-noise kr) 0.3))

(Mce (k2a (mul (white-noise kr) 0.3))
     (mul (white-noise ar) 0.3))

(let* ((blockSize 64) ;; no UGen for this?
       (freq (mul (fdiv (mouse-x kr 0.1 40 1 0.1) blockSize) sample-rate)))
  (mul (Mce (k2a (lfnoise0 kr freq))
	    (lfnoise0 ar freq))
       0.3))
