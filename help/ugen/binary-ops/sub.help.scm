;; (sub a b)

;; subtraction, written '-' in sclang.

;; Silence.

(let ((z (fsin-osc ar 800 0)))
  (audition
   (out 0 (sub z z))))


