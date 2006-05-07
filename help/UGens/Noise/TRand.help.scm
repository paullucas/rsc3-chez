;; (TRand lo hi trig)

;; Generates a random float value in uniform distribution from lo each
;; time the trig signal changes from nonpositive to positive values

(Mul 
 (SinOsc ar (TRand (Mce 200 1600) (Mce 500 3000) (Dust kr (Mce 5 12))) 0)
 0.2)
