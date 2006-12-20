;; (IsStrictlyPositive a)

;; Predicate to determine if a value is strictly positive.

(define (IsStrictlyPositive a)
  (GT a 0.0))

(let* ((a (Line ar -1 1 1 removeSynth))
       (b (IsStrictlyPositive a))
       (f (MulAdd (Mce a b) 600 900)))
  (Mul (SinOsc ar f 0) 0.1))
