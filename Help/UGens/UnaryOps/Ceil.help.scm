;; (Ceil a)

;; Round signal up.

(let* ((x (mouse-x kr 65 95 0 0.1))
       (f (MIDICPS (Mce (Floor x) (Ceil x)))))
  (mul (sin-osc ar f 0) 0.1))
