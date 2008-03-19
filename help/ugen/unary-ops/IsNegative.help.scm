;; (IsNegative a)

;; Predicate to determine if a value is negative.

(define (IsNegative a)
  (LT a 0.0))

(let* ((a (line ar -1 1 1 remove-synth))
       (b (IsNegative a))
       (f (mul-add (Mce a b) 600 900)))
  (mul (sin-osc ar f 0) 0.1))
