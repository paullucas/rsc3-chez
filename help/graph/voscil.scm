;; voscil (rd)

(let* ((b 32)
       (hb (/ (- b 1) 2))
       (n (* 8192 4))
       (r 6)
       (f 600)
       (s (add
           (pan2 (add (v-osc ar (mul-add (lf-noise0 kr r) hb hb) (* f 2) 0)
                      (mul (blip ar
                                 (mul-add (lf-noise0 kr r) 40 600)
                                 (mul-add (lf-noise0 kr r) 16 24))
                           (mul-add (lf-noise0 kr r) 0.1 0.1)))
                 (lf-noise0 kr r)
                 (mul-add (lf-noise0 kr r) 0.5 0.5))
           (pan2 (v-osc ar (mul-add (lf-saw kr (/ 1 r) 0) hb hb) f 0)
                 (lf-noise0 kr r)
                 (mul-add (lf-noise0 kr r) 0.5 0.5)))))
  (with-sc3
   (lambda (fd)
     (for-each
      (lambda (i)
        (async fd (b-alloc i n 1))
        (replicate-m
         (i-random 2 512)
         (send fd (b-set1 i (i-random 0 n) (random -1 1)))))
      (enum-from-to 0 (- b 1)))
     (play fd (out 0 s)))))
