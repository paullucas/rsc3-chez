;; (Floor a)

;; Round signal down.

(let* ((x (MouseX kr 65 95 0 0.1))
       (f (MIDICPS (Floor x))))
  (Mul (SinOsc ar f 0) 0.1))
