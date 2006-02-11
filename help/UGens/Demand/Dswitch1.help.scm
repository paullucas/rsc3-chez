;; (Dswitch1 index array)

;; Demand rate generator for switching between inputs

;; index	which of the inputs to return
;; array	array of values or other ugens

(let* ((a (Dswitch1 (MouseX kr 0 4 0 0.1)
		    (Mce 1 3 (MouseY kr 1 15 0 0.1) 2 (Dwhite R0 2 0 3))))
       (trig (Impulse kr 3 0))
       (freq (MulAdd (Demand trig 0 a) 30 340)))
  (Mul (SinOsc ar freq 0) 0.1))
