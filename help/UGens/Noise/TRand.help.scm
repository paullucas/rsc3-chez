;; (TRand lo hi trig)
 
;; Generates a random float value in uniform distribution from lo each
;; time the trig signal changes from nonpositive to positive values
 
(SinOsc.ar (TRand.kr '(200 1600) '(500 3000) (Dust.kr '(5 12))) 0 0.2)
