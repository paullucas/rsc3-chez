;; lf pulses (rd)

(let* ((n0 (LFNoise0 ar (mce2 20 40)))
       (n1 (LFNoise0 ar (mce2 5 10)))
       (x (MouseX kr 0.012 0.19 1 0.1))
       (f (Formlet (Blip ar 10 12) (MulAdd n0 43 700) 0.005 x))
       (o (Mul (SinOsc ar 40 0) n1)))
  (audition (Out 0 (Clip2 (Add f o) 1))))
