;; (Drand  length array)
;; (Drandx length array)

;; Demand rate random sequence generators.

;; length	number of values to return
;; array	array of values or other ugens

;; Dxrand never plays the same value twice, whereas Drand chooses any
;; value in the list.

(let* ((a (Drand R0 inf (Mce 1 3 2 7 8)))
       (trig (Impulse kr (MouseX kr 1 400 1 0.1) 0))
       (freq (MulAdd (Demand trig 0 a) 30 340)))
  (Mul (SinOsc ar freq 0) 0.1))

(let* ((a (Dxrand R0 inf (Mce 1 3 2 7 8)))
       (trig (Impulse kr (MouseX kr 1 400 1 0.1) 0))
       (freq (MulAdd (Demand trig 0 a) 30 340)))
  (Mul (SinOsc ar freq 0) 0.1))
