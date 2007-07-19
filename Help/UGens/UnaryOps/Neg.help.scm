;; (Neg a)

;; Negation.

(let ((s (SinOsc ar 440 0)))
  (Mce (Mul s 0.1)
       (Add s (Neg s))))
