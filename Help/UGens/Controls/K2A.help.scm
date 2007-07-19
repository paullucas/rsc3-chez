;; (K2A in)

;; Control rate to audio rate converter.

;; To be able to play a control rate UGen into an audio rate UGen,
;; sometimes the rate must be converted.  K2A converts via linear
;; interpolation.

;; in - input signal

(K2A (Mul (WhiteNoise kr) 0.3))

(Mce (K2A (Mul (WhiteNoise kr) 0.3))
     (Mul (WhiteNoise ar) 0.3))

(let* ((blockSize 64) ;; no UGen for this?
       (freq (Mul (FDiv (MouseX kr 0.1 40 1 0.1) blockSize) SampleRate)))
  (Mul (Mce (K2A (LFNoise0 kr freq))
	    (LFNoise0 ar freq))
       0.3))
