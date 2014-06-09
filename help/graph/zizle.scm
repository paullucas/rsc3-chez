;; zizle (jmcc) #SC3d1.5

(import (rsc3) (rsc3 lang))

(define rrand rand-range)
(define two-pi (* 2 pi))

(define zizle
  (let* ((a (lambda (f)
              (mix (mul (sin-osc ar (mul f (mce2 (rrand 0.7 1.3) 1)) (mce2 (rand* two-pi) (rand* two-pi))) 0.1))))
         (a1 (u:max (a (exp-rand 0.38 8)) 0))
         (a2 (u:abs (a (exp-rand 6 24)))))
    (pan2 (mul (sin-osc ar (midi-cps (rrand 24 108)) (rand* two-pi)) (mul a1 a2)) (rand2 1) 1)))

(with-sc3 (overlap-texture-u (list 4 4 12 +inf.0) zizle))
