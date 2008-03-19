;; (Sign a)

;; Sign function.  -1 when a < 0, +1 when a > 0, 0 when a is 0

(let* ((a (line ar -1 1 1 remove-synth))
       (b (Sign a))
       (f (mul-add (Mce a b) 600 900)))
  (mul (sin-osc ar f 0) 0.1))
