;; (IsNegative a)

;; Predicate to determine if a value is negative.

(define (IsNegative a)
  (LT a 0.0))

(let* ((a (Line ar -1 1 1 removeSynth))
       (b (IsNegative a))
       (f (MulAdd (Mce a b) 600 900)))
  (Mul (SinOsc ar f 0) 0.1))
