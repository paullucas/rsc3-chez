;; (IsPositive a)

;; Predicate to determine if a value is positive.

(define (IsPositive a)
  (GE a 0.0))

(let* ((a (Line ar -1 1 1 removeSynth))
       (b (IsPositive a))
       (f (MulAdd (Mce a b) 600 900)))
  (Mul (SinOsc ar f 0) 0.1))
