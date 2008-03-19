;; (IsStrictlyPositive a)

;; Predicate to determine if a value is strictly positive.

(define (IsStrictlyPositive a)
  (GT a 0.0))

(let* ((a (line ar -1 1 1 remove-synth))
       (b (IsStrictlyPositive a))
       (f (mul-add (mce2 a b) 600 900)))
  (mul (sin-osc ar f 0) 0.1))
