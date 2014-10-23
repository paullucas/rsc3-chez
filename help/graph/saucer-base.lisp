(define saucer-base
  (let ((b (rand 0 1000))
        (c (rand 0 5000))
        (o (+ (* (sin-osc ar (rand 0 20) 0) b) (* 1.1 b)))
        (p (+ (* (sin-osc ar o 0) c) (* 1.1 c))))
    (pan2 (* (sin-osc ar p 0) 0.1) (rand -1 1) 1)))

(with-sc3 (overlap-texture-u (list 2 6 4 inf) saucer-base))
