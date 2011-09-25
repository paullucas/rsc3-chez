;; lf pulses (rd)

(import (rsc3))

(let* ((n0 (lf-noise0 ar (mce2 20 40)))
       (n1 (lf-noise0 ar (mce2 5 10)))
       (x (mouse-x* kr 0.012 0.19 1 0.1))
       (f (formlet (blip ar 10 12) (mul-add n0 43 700) 0.005 x))
       (o (mul (sin-osc ar 40 0) n1)))
  (audition (out 0 (clip2 (add f o) 1))))
