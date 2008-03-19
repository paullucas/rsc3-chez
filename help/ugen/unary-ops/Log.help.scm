;; (Recip a)

;; Reciprocal.

(let* ((a (line ar -2 2 2 remove-synth))
       (b (Recip a))
       (f (mul-add (Mce a b) 600 900)))
  (mul (sin-osc ar f 0) 0.1))
