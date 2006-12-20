;; (RandSeed trig seed)
 
;; When the trigger signal changes from nonpositive to positve, the
;; synth's random generator seed is reset to the given value. All
;; other synths that use the same random number generator reproduce
;; the same sequence of numbers again.  

;; See also: RandID.
 
;; Start a noise patch 

(let ((noise (Add (Mul (WhiteNoise ar) (Mce 0.05 0.05)) (Dust2 ar (Mce 70 70))))
      (freq (MulAdd (LFNoise1 kr 3) 5500 6000)))
  (Add (Resonz (Mul noise 5) freq 0.5) 
       (Mul noise 0.5)))

;; Reset the seed at a variable rate.

(Mrg (RandSeed kr (Impulse kr (MouseX kr 0.1 100 0 0.1) 0) 1956))
