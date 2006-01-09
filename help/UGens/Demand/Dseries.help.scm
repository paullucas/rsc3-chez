;; (Dseries length start step)

;; Demand rate arithmetic series ugen.

;; length	number of values to create
;; start	start value
;; step 	step value

;; The arguments can be a number or any other ugen

(let* ((a (Dseries 15 0 1))
       (trig (Impulse kr (MouseX kr 1 40 1 0.1) 0))
       (freq (MulAdd (Demand trig 0 a) 30 340)))
  (Mul (SinOsc ar freq 0) 0.1))
