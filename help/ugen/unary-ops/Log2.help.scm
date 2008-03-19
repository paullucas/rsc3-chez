;; (Log2 a)

;; Base two logarithm.

(let* ((a (line ar -2 2 3 remove-synth))
       (b (Log2 a))
       (f (mul-add (Mce a b) 600 900)))
  (mul (sin-osc ar f 0) 0.1))
