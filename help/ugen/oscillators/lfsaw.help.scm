;; (lfsaw rate freq iphase)

;; sawtooth oscillator.  A non-band-limited sawtooth
;; oscillator. output ranges from -1 to +1.

;; freq   - frequency in Hertz
;; iphase - phase in radians

(audition (out 0 (mul (lfsaw ar 500 1) 0.1)))

;; Used as both oscillator and LFO.

(let ((f (mul-add (lfsaw kr 4 0) 400 400)))
  (audition (out 0 (mul (lfsaw ar f 0) 0.1))))
