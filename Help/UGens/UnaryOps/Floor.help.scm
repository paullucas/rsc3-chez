;; (Floor a)

;; Round signal down.

(let* ((x (mouse-x kr 65 95 0 0.1))
       (f (MIDICPS (Floor x))))
  (mul (sin-osc ar f 0) 0.1))
