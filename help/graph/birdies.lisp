(define birdies
  (let ((p1 (+ (* (lf-pulse kr (+ 0.4 (rand 0 1)) 0 (+ (rand 0 0.8) 0.1)) (+ (rand 0 3) 4)) 2))
        (p2 (* (lf-pulse kr (+ 0.4 (rand 0 1)) 0 (+ (rand 0 0.8) 0.1)) (+ (rand 0 3) 4)))
        (p3 (* (lf-pulse kr (+ 0.2 (rand 0 0.5)) 0 0.4) 0.02))
        (sw (+ (* (lf-saw kr (+ p1 p2) 0) (neg (+ 1000 (rand 0 800)))) (+ 4000 (rand2 1200))))
        (freq (lag sw 0.05))
        (amp (lag p3 0.3)))
    (pan2 (* (sin-osc ar freq 0) amp) (rand2 1) 1)))

(with-sc3 (overlap-texture-u (list 7 4 4 inf) birdies))
