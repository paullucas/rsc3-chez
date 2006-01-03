;; (RandSeed trig seed)
 
;; When the trigger signal changes from nonpositive to positve, the
;; synth's random generator seed is reset to the given value. All
;; other synths that use the same random number generator reproduce
;; the same sequence of numbers again.  

;; See also: RandID.
 
;; Start a noise patch 

(let ((noise (Add (WhiteNoise ar '(0.05 0.05)) (Dust2 ar '(70 70))))
      (freq (LFNoise1 kr 3 5500 6000)))
  (Add (Resonz ar (Mul noise 5) freq 0.5) (Mul noise 0.5)))

;; Reset the seed at a variable rate.  (Note: This cannot be 'played'
;; in rsc.)

(RandSeed kr (Impulse kr (MouseX kr 0.1 100)) 1956)
