;; adso (rd)

(import (sosc) (rsc3) (rhs))

(let* ((n 24)
       (rand-l
        (lambda (n l r)
          (replicate-m n (random l r))))
       (adso
        (let* ((b-get
                (lambda (b n)
                  (let ((j (make-mce (enum-from-to 0 (- n 1)))))
                    (buf-rd-n 1 kr b j 0))))
               (m (sin-osc kr (b-get 3 n) 0))
               (f (mul (midi-cps (b-get 0 n))
                       (mul-add m (b-get 4 n) 1))))
          (out 0 (mix (pan2 (sin-osc ar f 0)
                            (b-get 2 n)
                            (b-get 1 n))))))
       (pattern
        (lambda (fd)
          (lambda (t)
            (let ((z (map floor
                          (replicate-m
                           n (random (random 22 48)
                                     (random 54 122)))))
                  (rn (lambda (i j k)
                        (send fd (b-setn1 i 0 (rand-l n j k))))))
              (send fd (b-setn1 0 0 z))
              (rn 1 0 0.1)
              (rn 2 -1 1)
              (rn 3 2 12)
              (rn 4 0.001 0.0075)
              (rn 5 1 24)
              (rn 6 0.05 (random 0.075 2.4))
              (thread-sleep t))))))
  (with-sc3
   (lambda (fd)
     (for-each
      (lambda (i)
        (async fd (b-alloc i n 1)))
      (enum-from-to 0 6))
     (play fd adso)
     (map (pattern fd)
          (replicate-m
           32
           (choose
            (list 0.025 0.05 0.075 0.1 0.125 2.5))))
     (reset fd))))
