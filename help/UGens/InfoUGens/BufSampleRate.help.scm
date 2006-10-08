;; (BufSampleRate bufnum)

;; Buffer sample rate.

(->< s (/b_allocRead 0 "/home/rohan/sw/sw-01/audio/metal.wav" 0 0))

;; Compare a sine tone derived from sample rate of a buffer with a
;; 440Hz tone.

(let ((freq (Mce (Mul (BufSampleRate ir 0) 0.01) 440)))
  (Mul (SinOsc ar freq 0) 0.1))
