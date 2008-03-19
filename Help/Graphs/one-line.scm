;; one-line (lance putnam)

(let* ((lfs (MulAdd (LFSaw ar (mce2 1 0.99) (mce2 0 0.6)) 2000 2000))
       (lfs_t (Mul (Trunc lfs (mce2 400 600)) (mce2 1 -1)))
       (f (OnePole (mix lfs_t) 0.98)))
  (audition (Out 0 (Pan2 (SinOsc ar f 0) 0 0.1))))
