;; (TRand lo hi trig)

;; Generates a random float value in uniform distribution from lo each
;; time the trig signal changes from nonpositive to positive values

(Mul 
 (SinOsc ar (TRand r0 (Mce 200 1600) (Mce 500 3000) (Dust r0 kr (Mce 5 12))) 0)
 0.2)
