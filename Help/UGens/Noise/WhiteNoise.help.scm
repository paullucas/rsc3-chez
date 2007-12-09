;; (WhiteNoise rate)

;; Generates noise whose spectrum has equal power at all frequencies.

(audition (Out 0 (Mul (WhiteNoise ar) 0.15)))

;; Noise generators constructors are unique, to share noise UGens
;; values must be explictly stored and reused.

(audition (Out 0 (Mul (Sub (WhiteNoise ar) (WhiteNoise ar)) 0.15)))

(let ((n (WhiteNoise ar)))
  (audition (Out 0 (Sub n n))))
