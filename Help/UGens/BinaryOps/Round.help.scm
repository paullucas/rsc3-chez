;; (Round a b)

;; Rounds a to the nearest multiple of b.

(let* ((x (mouse-x kr 60 4000 0 0.1))
       (f (Round x 100)))
  (mul (sin-osc ar f 0) 0.1))

(let ((n (line kr 24 108 6 remove-synth)))
  (mul (saw ar (MIDICPS (Round n 1))) 0.2))
