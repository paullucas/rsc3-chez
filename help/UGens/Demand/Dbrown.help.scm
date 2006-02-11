;; (Dbrown  length lo hi step)
;; (Dibrown length lo hi step)

;; Demand rate brownian movement generators.

;; lo		minimum value
;; hi 		maximum value
;; step		maximum step for each new value
;; length	number of values to create

;; Dbrown returns numbers in the continuous range between lo and hi,
;; Dibrown returns integer values.  The arguments can be a number or
;; any other ugen.

(let* ((a (Dbrown R0 inf 0 15 1))
       (trig (Impulse kr (MouseX kr 1 40 1 0.1) 0))
       (freq (MulAdd (Demand trig 0 a) 30 340)))
  (Mul (SinOsc ar freq 0) 0.1))

(let* ((a (Dibrown R0 inf 0 15 1))
       (trig (Impulse kr (MouseX kr 1 40 1 0.1) 0))
       (freq (MulAdd (Demand trig 0 a) 30 340)))
  (Mul (SinOsc ar freq 0) 0.1))
