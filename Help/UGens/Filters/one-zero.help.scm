;; (one-zero in coef)

;; One zero filter

(one-zero (mul (white-noise ar) 0.5) 0.5)

(one-zero (mul (white-noise ar) 0.5) -0.5)

(one-zero (mul (white-noise ar) 0.5) (line kr -0.5 0.5 10 remove-synth))
