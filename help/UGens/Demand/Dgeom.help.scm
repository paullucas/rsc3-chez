;; (Dgeom length start grow)

;; Demand rate geometric series ugen.

;; start	start value
;; grow 	value by which to grow ( x = x[-1] * grow )
;; length	number of values to create
		
;; The arguments can be a number or any other ugen

(let* ((a (Dgeom 15 1 1.2))
       (trig (Impulse kr (MouseX kr 1 40 1 0.1) 0))
       (freq (MulAdd (Demand trig 0 a) 30 340)))
  (Mul (SinOsc ar freq 0) 0.1))
