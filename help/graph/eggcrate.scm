;; eggcrate (rd)

(import (rsc3))

(let* ((eggcrate
        (lambda (u v)
          (mul (u:cos (mul u pi)) (u:sin (mul v pi)))))
       (p (make-mce (list 64 72 96 128 256 6400 7200 8400 9600)))
       (x (brown-noise kr))
       (y (brown-noise kr))
       (t (dust kr 2.4))
       (f0 (t-choose t p))
       (f1 (t-choose t p))
       (f (lin-lin (eggcrate x y) -1 1 f0 f1))
       (a (lin-lin x -1 1 0 0.1)))
  (audition (out 0 (pan2 (mix (sin-osc ar f 0)) y a))))
