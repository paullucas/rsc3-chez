;; (Tan a)

;; Tangent.

(let* ((a (line kr (- pi) pi 1 remove-synth))
       (b (sub (fdiv (Tan a) (/ pi 2)) 1))
       (f (mul-add b 900 1600)))
  (mul (sin-osc ar f 0) 0.1))
