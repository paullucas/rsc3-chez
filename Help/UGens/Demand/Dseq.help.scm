;; (Dseq length array)

;; Demand rate sequence generator.

;; array  - array of values or other ugens
;; length - number of repeats

(let* ((a (Dseq 3 (Mce 1 3 2 7 8)))
       (t (Impulse kr (MouseX kr 1 40 1 0.1) 0))
       (f (MulAdd (Demand t 0 a) 30 340)))
  (audition (Mul (SinOsc ar f 0) 0.1)))

(let* ((a (Dseq +inf.sc (make-mce (randl 32 0 10))))
       (t (Impulse ar (MouseX kr 1 10000 1 0.1) 0))
       (f (MulAdd (Demand t 0 a) 30 340)))
  (audition (Mul (SinOsc ar f 0) 0.1)))
