;; (AbsDif a b)

;; Calculates the value of (abs (- a b). Finding the magnitude of the
;; difference of two values is a common operation.

(FSinOsc.ar 440 0 (AbsDif 0.2 (FSinOsc.ar 2 0 0.5)))
