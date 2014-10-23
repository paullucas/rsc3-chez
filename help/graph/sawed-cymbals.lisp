(define sawed-cymbals
  (let ((y (let ((f1 (rand 500 2500))
                 (f2 (rand 0 8000))
                 (f (uclone 15 (rand f1 (+ f1 f2))))
                 (rt (uclone 15 (rand 2 6))))
             (klank-spec f (uclone 15 1) rt)))
        (z (uclone 2 y))
        (f-s (x-line kr (rand 0 600) (rand 0 600) 12 do-nothing)))
    (klank (* (lf-saw ar f-s 0) 0.0005) 1 0 1 (mce-transpose z))))

(with-sc3 (overlap-texture-u (list 4 4 6 inf) sawed-cymbals))
