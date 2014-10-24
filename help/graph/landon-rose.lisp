(define nt
  (list
   (list 32 43 54 89)
   (list 10 34 80 120)
   (list 67 88 90 100)
   (list 76 88 99 124)))

(define fr (map (map midi-cps) nt))

(define nd
  (lambda (e f)
    (let ((p (klank-data f (replicate 4 1) (replicate 4 3)))
          (x (* (* e (pink-noise ar)) (mce2 0.0011 0.0012))))
      (klank x 1 0 1 p))))

(define env (lambda (i) (abs (sin-osc ar (/ 1 8) (* (/ i 2) pi)))))

(define lr (sum (zip-with nd (map env (enum-from-to 0 3)) fr)))

(audition (out 0 lr))
