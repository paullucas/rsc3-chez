;; (fos in a0 a1 b1)

;; First order filter section.

;; Same as one-pole.

(let ((x (mul (lftri ar 0.4 0) 0.99))
      (i (mul (lfsaw ar 200 0) 0.2)))
  (audition (out 0 (fos i (sub 1 (Abs x)) 0 x))))

;; Same as one-zero

(let ((x (mul (lftri ar 0.4 0) 0.99))
      (i (mul (lfsaw ar 200 0) 0.2)))
  (audition (out 0 (fos i (sub 1 (Abs x)) x 0))))
