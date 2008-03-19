;; (lftri rate freq iphase)

;; A non-band-limited triangular waveform oscillator. output ranges
;; from -1 to +1.

(audition (out 0 (mul (lftri ar 500 1) 0.1)))

;; Used as both oscillator and LFO.

(let ((f (mul-add (lftri kr 4 0) 400 400)))
  (audition (out 0 (mul (lftri ar f 0) 0.1))))
