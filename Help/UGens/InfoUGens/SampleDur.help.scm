;; SampleDur

;; Duration of one sample.  Equivalent to 1 / SampleRate.

;; Compare a sine tone derived from sample rate with a 440Hz tone.

(let ((freq (Mce (Mul (Recip SampleDur) 0.01) 440)))
  (Mul (SinOsc ar freq 0) 0.1))
