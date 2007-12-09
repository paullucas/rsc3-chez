;; (SetResetFF trig reset)

;; Set-reset flip flop.  Output is set to 1.0 upon receiving a trigger
;; in the set input, and to 0.0 upon receiving a trigger in the reset
;; input. Once the flip flop is set to zero or one further triggers in
;; the same input are have no effect. One use of this is to have some
;; precipitating event cause something to happen until you reset it.

;; trig  - trigger sets output to one
;; reset - trigger resets output to zero

(let ((n (BrownNoise ar))
      (g (SetResetFF (Dust ar 5) (Dust ar 5))))
  (audition (Out 0 (Mul* n g 0.2))))
