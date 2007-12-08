;; (LFSaw rate freq iphase)

;; Sawtooth oscillator.  A non-band-limited sawtooth
;; oscillator. Output ranges from -1 to +1.

;; freq   - frequency in Hertz
;; iphase - phase in radians

(audition (Out 0 (Mul (LFSaw ar 500 1) 0.1)))

;; Used as both Oscillator and LFO.

(let ((f (MulAdd (LFSaw kr 4 0) 400 400)))
  (audition (Out 0 (Mul (LFSaw ar f 0) 0.1))))
