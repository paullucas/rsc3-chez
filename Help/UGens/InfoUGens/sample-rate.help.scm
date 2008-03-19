;; sample-rate

;; Server sample rate.

;; Compare a sine tone derived from sample rate with a 440Hz tone.

(let ((freq (Mce (mul sample-rate 0.01) 440)))
  (mul (sin-osc ar freq 0) 0.1))
