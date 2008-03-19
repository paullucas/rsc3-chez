;; (mul-add a b c)

;; Functionally equivalent to (add (mul a b) c).

(let ((f (mul-add (lfsaw kr (Mce 10 9) 0) 200 400)))
  (audition (out 0 (mul (sin-osc ar f 0) 0.1))))

(let ((f (add (mul (lfsaw kr (Mce 10 9) 0) 200) 400)))
  (audition (out 0 (mul (sin-osc ar f 0) 0.1))))
