;; (Dswitch1 index array)

;; Demand rate generator for switching between inputs

;; index	which of the inputs to return
;; array	array of values or other ugens

(let* ((x (MouseX kr 0 4 0 0.1))
       (y (MouseY kr 1 15 0 0.1))
       (a (Dswitch1 x (make-mce (list 1 3 y 2 (Dwhite 2 0 3)))))
       (t (Impulse kr 3 0))
       (f (MulAdd (Demand t 0 a) 30 340)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.1))))
