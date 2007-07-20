;; (BufAllpassC buf in delaytime decaytime)

;; Buffer based all pass delay line with cubic interpolation

;; All pass delay line with cubic interpolation which uses a buffer
;; for its internal memory. See also BufAllpassN which uses no
;; interpolation, and BufAllpassL which uses linear
;; interpolation. Cubic interpolation is more computationally
;; expensive than linear, but more accurate.

;; See also AllpassC.

;; buf - buffer number.

;; in - the input signal.

;; delaytime - delay time in seconds.

;; decaytime - time for the echoes to decay by 60 decibels. If this
;;             time is negative then the feedback coefficient will be
;;             negative, thus emphasizing only odd harmonics at an
;;             octave lower.

(->< s (/b_alloc 0 44100 1))

(let ((x (Mul* (Decay (Dust ar 1) 0.2) (WhiteNoise ar) 0.5)))
  (BufAllpassN 0 x 0.25 6))