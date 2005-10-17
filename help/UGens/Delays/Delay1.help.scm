;;; (Delay1 in)

;;; Fixed Single sample delay.

(let ((s (Impulse.ar 1)))
  (Add s (Delay1.ar s)))
