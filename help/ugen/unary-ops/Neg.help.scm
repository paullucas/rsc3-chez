;; (Neg a)

;; Negation.

(let ((s (sin-osc ar 440 0)))
  (Mce (mul s 0.1)
       (add s (Neg s))))
