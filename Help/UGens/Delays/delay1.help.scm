;; (delay1 in)

;; Fixed Single sample delay.

(let ((s (impulse ar 1 0)))
  (add s (delay1 s)))
