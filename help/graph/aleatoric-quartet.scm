;; aleatoric quartet (jmcc) #7

(import (rnrs) (rsc3) (rhs))

(define aleatoric-quartet
  (let* ((amp 0.4)
         (density (mouse-x kr 0.01 1 0 0.1))
         (dmul (mul (recip density) (mul 0.5 amp)))
         (dadd (add (neg dmul) amp))
         (rapf (lambda (i)
                 (let ((r (mce2 (rand 0 0.05) (rand 0 0.05))))
                   (allpass-n i 0.05 r 1))))
         (rapfn (lambda (n i)
                  ((foldl1 compose (replicate n rapf)) i)))
         (mk-f (lambda ()
                 (let* ((i0 (i-rand 0 2))
                        (r0 (select i0 (mce3 1 0.5 0.25)))
                        (r1 (rand -30 30))
                        (n0 (lf-noise0 kr r0))
                        (m (u:round (mul-add n0 7 (add 66 r1)) 1)))
                   (midi-cps (lag m 0.2)))))
         (mk-s (lambda (_)
                 (let* ((f (recip (mk-f)))
                        (r (rand -1 1))
                        (n0 (pink-noise ar))
                        (n1 (lf-noise1 kr 8))
                        (x (mul n0 (u:max 0 (mul-add n1 dmul dadd)))))
                   (pan2 (comb-l x 0.02 f 3) r 1))))
         (g (mix-fill 4 mk-s)))
    (leak-dc (rapfn 4 g) 0.995)))

(audition (out 0 aleatoric-quartet))
