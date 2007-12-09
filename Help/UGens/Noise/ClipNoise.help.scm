;; (ClipNoise rate)

;; Generates noise whose values are either -1 or 1.  This produces the
;; maximum energy for the least peak to peak amplitude.

(audition (Out 0 (Mul (ClipNoise ar) 0.2)))
