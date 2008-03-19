;; (add a b)

;; addition, written '+' in sclang.

(add (mul (fsin-osc ar 800 0) 0.1)
     (mul (pink-noise ar) 0.1))

;; DC offset.

(add (fsin-osc ar 440 0) 0.1)
