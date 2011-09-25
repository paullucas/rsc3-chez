;; bottle (sc)

(import (rsc3) (rhs))

(let* ((freq
        (rand 220 880))
       (perc
        (env-perc 0.1 0.6 1 (list -4 -4)))
       (flute
        (ringz (mul (env-gen kr 1 1 0 1 0 perc)
                    (mul (white-noise ar) 0.02))
               freq
               0.3))
       (breath
        (mul (env-gen kr 1 1 0 1 0 perc)
             (resonz (pink-noise ar)
                     (add 5 (fdiv freq 2))
                     0.1)))
       (rapf
        (lambda (i)
          (add i (mul (allpass-n i 0.1 (lin-rand 0.001 0.1 -1) 1.0) 0.5))))
       (close
        (lambda (i)
          (let* ((l (env-linen 0.01 3.0 1.0 1 (replicate 3 -4)))
                 (z (mul (add breath i)
                         (env-gen kr 1 1 0 1 2 l))))
            (mce2 z z)))))
  (audition (out 0 (close ((foldl1 compose (replicate 2 rapf)) flute)))))
