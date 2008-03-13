;; (Dgeom length start grow)

;; Demand rate geometric series ugen.

;; start	start value
;; grow 	value by which to grow ( x = x[-1] * grow )
;; length	number of values to create
		
;; The arguments can be a number or any other ugen

(let* ((a (Dgeom 15 1 1.2))
       (t (Impulse kr (MouseX kr 1 40 1 0.1) 0))
       (f (MulAdd (Demand t 0 a) 30 340)))
  (audition (Mul (SinOsc ar f 0) 0.1)))

;; Demand rate UGens are not shared...

(let* ((a  (Dgeom 15 1 1.2))
       (t  (Impulse ar (MouseX kr 1 40 1 0.1) 0))
       (f0 (MulAdd (Demand (Delay1 t) 0 a) 30 340))
       (f1 (MulAdd (Demand t 0 a) 30 340)))
  (audition (Out 0 (Mul (SinOsc ar (mce2 f0 f1) 0) 0.1))))

(let* ((a0 (Dgeom 15 1 1.2))
       (a1 (Dgeom 15 1 1.2))
       (t  (Impulse ar (MouseX kr 1 40 1 0.1) 0))
       (f0 (MulAdd (Demand (Delay1 t) 0 a0) 30 340))
       (f1 (MulAdd (Demand t 0 a1) 30 340)))
  (audition (Out 0 (Mul (SinOsc ar (mce2 f0 f1) 0) 0.1))))
