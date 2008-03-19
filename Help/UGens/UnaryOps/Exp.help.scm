;; (Exp a)

;; Exponential.

(let* ((a (line ar -2 2 3 remove-synth))
       (b (Exp a))
       (f (mul-add (Mce a b) 600 900)))
  (mul (sin-osc ar f 0) 0.1))
