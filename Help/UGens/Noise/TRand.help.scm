;; (TRand lo hi trig)

;; Generates a random float value in uniform distribution from lo each
;; time the trig signal changes from nonpositive to positive values

(let* ((t (Dust kr (Mce 5 12)))
       (f (TRand (Mce 200 1600) (Mce 500 3000) t)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.2))))
