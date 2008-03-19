;; sample-dur

;; Duration of one sample.  Equivalent to 1 / sample-rate.

;; Compare a sine tone derived from sample rate with a 440Hz tone.

(let ((freq (Mce (mul (Recip sample-dur) 0.01) 440)))
  (mul (sin-osc ar freq 0) 0.1))
