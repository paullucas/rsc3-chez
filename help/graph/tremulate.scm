;; tremulate (jmcc) #1

(import (rsc3) (rsc3 lang))

(define tremulate
  (let* ((f (rand 500 900))
         (o (f-sin-osc ar (mul f (make-mce '(1 1.2 1.5 1.8))) 0))
         (r (rand-n 4 30 90))
         (a (u:max 0 (mul (lf-noise2 kr r) 0.1)))
         (l (rand-n 4 -1 1)))
    (mix (pan2 o l a))))

(define tremulate-pp
  (lambda (i)
    (comb-n i 0.1 0.1 1)))

(with-sc3*
 (post-process-u 2 tremulate-pp)
 (xfade-texture-u (list 0.5 2 +inf.0) tremulate))
