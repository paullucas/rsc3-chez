;; (Ceil a)

;; Round signal up.

(let* ((x (MouseX kr 65 95 0 0.1))
       (f (MIDICPS (Mce (Floor x) (Ceil x)))))
  (Mul (SinOsc ar f 0) 0.1))
