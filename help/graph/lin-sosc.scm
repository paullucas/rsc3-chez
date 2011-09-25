;; lin-sosc (rd)

(import (sosc) (rsc3) (rhs))

(letrec
    ((n 1024)
     (two-pi (* 2.0 pi))
     (mk-line
      (lambda (n l r)
        (enum-from-then-to l (+ l (/ (- r l) n)) r)))
     (geom
      (lambda (n i s)
        (if (= n 0)
            nil
            (cons i (geom (- n 1) (* i s) s)))))
     (mk-xline
      (lambda (n l r)
        (geom n l (expt (/ r l) (/ 1 n)))))
     (rng
      (lambda (l r)
        (let ((m (- l r)))
          (lambda (e)
            (+ l (* e m))))))
     (s-rng
      (lambda (l r)
        (let* ((m (/ (- l r) 2))
               (n (+ m l)))
          (lambda (e)
            (+ n (* e m))))))
     (cmp
      (lambda (f g)
        (lambda (n)
          (f (g n)))))
     (tbl-m
      (lambda (b)
        (play-buf 1 b (mul (mouse-x* kr 0.001 1.0 0 0.1)
                           (buf-rate-scale kr b)) 0 0 1)))
     (tbl-c
      (lambda (b c)
        (play-buf 1 b (mul (in 1 kr c) (buf-rate-scale kr b)) 0 0 1)))
     (settr
      (lambda (fd n)
        (let* ((freq
                (list
                 (mk-line n 440.0 444.0)
                 (mk-line n 40.0 16000.0)
                 (mk-xline n 40.0 16000.0)
                 (map (cmp (s-rng 20 21000) sin) (mk-line n 0 two-pi))
                 (map (cmp (s-rng 20 12000) cos) (mk-line n 0 two-pi))
                 (map (cmp (s-rng 20 22000) tan) (mk-line n -0.76 0.76))
                 (map (cmp (s-rng 20 90) tan) (mk-line n -0.76 0.76))))
               (ampl
                (list
                 (mk-line n 0.1 1.0)
                 (mk-line n 1.0 0.1)
                 (mk-line n 0.5 0.01)
                 (mk-line n 0.01 0.5)
                 (mk-xline n 1.0 0.1)
                 (mk-xline n 0.1 1.0)
                 (map sin (mk-line n 0.0 two-pi))
                 (map cos (mk-line n 0.0 two-pi))
                 (map (lambda (n) (* n 0.001))
                      (map tan (mk-line n 0.0 two-pi)))))
               (f (choose freq))
               (a (choose ampl)))
          (send fd (b-setn1 0 0 f))
          (send fd (b-setn1 1 0 a))
          (send fd (c-set1 0 (choose (list 0.005 0.0075 0.01 0.025 0.05 0.075
                                           0.1 0.25 0.5 0.75
                                           0.8 0.85 1.0 1.005))))
          (choose (list 0.01 0.05 0.1 0.15 0.25 0.5 0.75))))))
  (with-sc3
   (lambda (fd)
     (async fd (b-alloc 0 n 1))
     (async fd (b-alloc 1 n 1))
     (play
      fd
      (out 0 (clip2 (pan2 (mul (sin-osc ar (tbl-m 0) 0)
                               (tbl-m 1))
                          (tbl-c 1 0)
                          0.025)
                    0.25)))
     (letrec ((pattern
               (lambda (fd)
                 (thread-sleep (settr fd n))
                 (pattern fd))))
       (pattern fd)))))
