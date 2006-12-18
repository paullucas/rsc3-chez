;; (LFSaw rate freq iphase)

;; Sawtooth oscillator.  A non-band-limited sawtooth
;; oscillator. Output ranges from -1 to +1.

;; freq   - frequency in Hertz
;; iphase - phase in radians

(Mul (LFSaw ar 500 1) 0.1)

;; Used as both Oscillator and LFO.

(Mul (LFSaw ar (MulAdd (LFSaw kr 4 0) 400 400) 0) 0.1)
