;; (Dwhite  length lo hi)
;; (Diwhite length lo hi)

;; Demand rate white noise random generators.

;; length	number of values to create
;; lo		minimum value
;; hi 		maximum value

;; Dwhite returns numbers in the continuous range between lo and hi,
;; Diwhite returns integer values.  The arguments can be a number or
;; any other ugen

(let* ((a (Dwhite +inf.sc 0 15))
       (t (Impulse kr (MouseX kr 1 40 1 0.1) 0))
       (f (MulAdd (Demand t 0 a) 30 340)))
  (Mul (SinOsc ar f 0) 0.1))

(let* ((a (Diwhite +inf.sc 0 15))
       (t (Impulse kr (MouseX kr 1 40 1 0.1) 0))
       (f (MulAdd (Demand t 0 a) 30 340)))
  (Mul (SinOsc ar f 0) 0.1))
