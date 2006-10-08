;; (BufDelayC buf in delaytime)

;; Buffer based simple delay line with cubic interpolation.

;; Simple delay line with cubic interpolation which uses a buffer for
;; its internal memory. See also BufDelayN which uses no
;; interpolation, and BufDelayL which uses linear interpolation. Cubic
;; interpolation is more computationally expensive than linear, but
;; more accurate.

;; See also DelayC.

;; buf       - buffer number.
;; in        - the input signal.
;; delaytime - delay time in seconds.

(->< s (/b_alloc 0 44100 1))

(let ((z (Mul* (Decay (Dust ar 1) 0.5) 0.3 (WhiteNoise ar))))
  (Add (BufDelayC 0 z 0.2) z))
