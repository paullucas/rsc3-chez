;; (WhiteNoise rate)

;; Generates noise whose spectrum has equal power at all frequencies.

(Mul (WhiteNoise ar) 0.15)

;; Noise generators constructors are unique, to share noise UGens
;; values must be explictly stored and reused.

(Mul (Sub (WhiteNoise ar) (WhiteNoise ar))
     0.15)

(let ((n (WhiteNoise ar)))
  (Sub n n))
