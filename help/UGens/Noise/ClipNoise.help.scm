;; (ClipNoise)

;; Generates noise whose values are either -1 or 1.  This produces the
;; maximum energy for the least peak to peak amplitude.

(Mul (ClipNoise r0 ar) 0.2)
