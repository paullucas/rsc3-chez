;; (Frac a)

;; Fractional part.

(let* ((a (line ar -2 2 3 remove-synth))
       (b (Frac a))
       (f (mul-add (Mce a b) 600 900)))
  (mul (sin-osc ar f 0) 0.1))
