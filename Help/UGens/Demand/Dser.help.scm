;; (Dser length array)

;; Demand rate sequence generator.

;; array  - array of values or other ugens
;; length - number of values to return

(let* ((a (Dser dinf (make-mce (list 1 3 2 7 8))))
       (x (MouseX kr 1 40 1 0.1))
       (t (Impulse kr x 0))
       (f (MulAdd (Demand t 0 a) 30 340)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.1))))
