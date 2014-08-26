;; sprinkler mouse (jmcc) #1

(import (rnrs) (rsc3))

(define sprinkler-mouse
  (let* ((f (mouse-x kr 0.2 50 linear 0.2))
         (t (mul (lf-pulse kr f 0 0.25) 0.1)))
    (bpz2 (mul (white-noise ar) t))))

(audition (out 0 sprinkler-mouse))
