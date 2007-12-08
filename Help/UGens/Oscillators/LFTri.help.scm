;; (LFTri rate freq iphase)

;; A non-band-limited triangular waveform oscillator. Output ranges
;; from -1 to +1.

(audition (Out 0 (Mul (LFTri ar 500 1) 0.1)))

;; Used as both Oscillator and LFO.

(let ((f (MulAdd (LFTri kr 4 0) 400 400)))
  (audition (Out 0 (Mul (LFTri ar f 0) 0.1))))
