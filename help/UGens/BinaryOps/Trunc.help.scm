;; (Trunc a b)

;; Truncate a to a multiple of b.

(let* ((x (MouseX kr 60 4000 0 0.1))
       (f (Trunc x 100)))
  (Mul (SinOsc ar f 0) 0.1))
