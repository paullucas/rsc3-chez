;; adso (rd)

(letrec ((n 24)
         (b-get
          (lambda (b n)
            (buf-rd 1 kr b (make-mce (enum-from-to 0 (- n 1))) 0 0)))
         (rand-l
          (lambda (n l r)
            (replicate-m n (random l r))))
         (pattern
          (lambda (fd)
            (let ((z (map floor
                          (replicate-m n (random (random 22 48)
                                                 (random 54 122))))))
              (send fd (b-setn1 0 0 z))
              (send fd (b-setn1 1 0 (rand-l n 0 .1)))
              (send fd (b-setn1 2 0 (rand-l n -1 1)))
              (send fd (b-setn1 3 0 (rand-l n 2 12)))
              (send fd (b-setn1 4 0 (rand-l n 0.001 0.0075)))
              (send fd (b-setn1 5 0 (rand-l n 1 24)))
              (send fd (b-setn1 6 0 (rand-l n 0.05 (random 0.075 2.4))))
              (thread-sleep (choose (list 0.025 0.05 0.075 0.1 0.125 2.5)))
              (pattern fd))))
         (adso
          (out 0 (mix (pan2 (sin-osc ar
                                     (mul (midi-cps (b-get 0 n))
                                          (mul-add (sin-osc kr (b-get 3 n) 0)
                                                   (b-get 4 n)
                                                   1))
                                     0)
                            (b-get 2 n)
                            (mul (b-get 1 n) 1))))))
  (with-sc3
   (lambda (fd)
     (for-each
      (lambda (i)
        (async fd (b-alloc i n 1)))
      (enum-from-to 0 6))
     (play fd adso)
     (pattern fd))))
