;; (IsPositive a)

;; Predicate to determine if a value is positive.

(define (IsPositive a)
  (GE a 0.0))

(let* ((a (line ar -1 1 1 remove-synth))
       (b (IsPositive a))
       (f (mul-add (Mce a b) 600 900)))
  (mul (sin-osc ar f 0) 0.1))
