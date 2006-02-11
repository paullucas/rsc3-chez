;; (Dwhite  length lo hi)
;; (Diwhite length lo hi)

;; Demand rate white noise random generators.

;; length	number of values to create
;; lo		minimum value
;; hi 		maximum value

;; Dwhite returns numbers in the continuous range between lo and hi,
;; Diwhite returns integer values.  The arguments can be a number or
;; any other ugen

(let* ((a (Dwhite R0 inf 0 15))
       (trig (Impulse kr (MouseX kr 1 40 1 0.1) 0))
       (freq (MulAdd (Demand trig 0 a) 30 340)))
  (Mul (SinOsc ar freq 0) 0.1))

(let* ((a (Diwhite R0 inf 0 15))
       (trig (Impulse kr (MouseX kr 1 40 1 0.1) 0))
       (freq (MulAdd (Demand trig 0 a) 30 340)))
  (Mul (SinOsc ar freq 0) 0.1))
