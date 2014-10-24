(define deep-trip
  (let ((f (midi-cps (+ (* (lf-noise1 kr (rand 0 0.3)) 60) 70)))
        (a2 (* (sin-osc kr (rand 0 40) 0) 0.1))
        (a1 (max 0 (* (lf-noise1 kr (rand 0 8)) a2)))
        (a (* (lf-noise2 ar (* f (rand 0 0.5))) a1))
        (z (* (sin-osc ar f 0) a))
        (s (pan2 z (lf-noise1 kr (rand 0 5)) 1))
        (c0 (comb-n s 0.5 (rand-n 2 0.3 0.5) 20))
        (c1 (comb-n s 0.5 (rand-n 2 0.3 0.5) 20)))
    (+ (+ s c0) c1)))

(with-sc3 (overlap-texture-u (list 4 12 4 inf) deep-trip))
