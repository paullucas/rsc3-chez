;; (buf-sample-rate bufnum)

;; Buffer sample rate.

(->< s (/b_allocRead 0 "/home/rohan/sw/sw-01/audio/metal.wav" 0 0))

;; Compare a sine tone derived from sample rate of a buffer with a
;; 440Hz tone.

(let ((freq (Mce (mul (buf-sample-rate ir 0) 0.01) 440)))
  (mul (sin-osc ar freq 0) 0.1))
