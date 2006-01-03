;; (Delay2 in)

;; Fixed two sample delay.

(let ((s (Impulse ar 1)))
  (Add s (Delay2 ar s)))

