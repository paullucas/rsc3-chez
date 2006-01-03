;; (TIRand lo hi trig)
 
;; Generates a random integer value in uniform distribution from lo to
;; hi each time the trig signal changes from nonpositive to positive
;; values
 
(Pan2 ar (PinkNoise ar 0.2) (TIRand kr -1 1 (Dust kr 10)))

(SinOsc ar (Add (Mul 150 (TIRand kr 4 12 (Dust kr 10))) '(0 1)) 0 0.1)

(require (lib "rscE.ss" "rscE"))

(graphu 
 (* (sinosc (kr (+ (* 150 (tirand 4 12 (dust 10))) '(0 1))) 0.0) 0.1))
