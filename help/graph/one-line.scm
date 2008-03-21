;; one-line (lance putnam)

(let* ((lfs (mul-add (lf-saw ar (mce2 1 0.99) (mce2 0 0.6)) 2000 2000))
       (lfs_t (mul (trunc lfs (mce2 400 600)) (mce2 1 -1)))
       (f (one-pole (mix lfs_t) 0.98)))
  (audition (out 0 (pan2 (sin-osc ar f 0) 0 0.1))))
