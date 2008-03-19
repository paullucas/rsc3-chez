;; (add a b)

;; addition, written '+' in sclang.

(audition
 (out 0 (add (mul (fsin-osc ar 800 0) 0.1)
	     (mul (pink-noise ar) 0.1))))

;; DC offset.

(audition
 (out 0 (add (fsin-osc ar 440 0) 0.1)))
