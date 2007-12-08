;; (HPZ2 in)

;; Two zero fixed highpass filter.

(audition (Out 0 (HPZ2 (Mul (WhiteNoise ar) 0.25))))
