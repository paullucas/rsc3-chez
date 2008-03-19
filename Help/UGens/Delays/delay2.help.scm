;; (delay2 in)

;; Fixed two sample delay.

(let ((s (impulse ar 1)))
  (add s (delay2 ar s)))

