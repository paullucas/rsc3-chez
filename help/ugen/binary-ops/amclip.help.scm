;; (amclip a b)

;; 0 when b <= 0, a*b when b > 0

(audition
 (out 0 (amclip (white-noise ar) (mul (fsin-osc kr 1 0) 0.2))))
