;; (Round a b)

;; Rounds a to the nearest multiple of b.

(let* ((x (MouseX kr 60 4000 0 0.1))
       (f (Round x 100)))
  (Mul (SinOsc ar f 0) 0.1))
