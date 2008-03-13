;; (Done src)

;; Outputs a unit signal if the 'done' flag of the unit at `src' is
;; set, else output zero.

(let* ((x (MouseX kr -1 1 0 0.1))
       (e (Linen x 0.1 0.1 0.5 doNothing))
       (l (Mul (SinOsc ar 880 0) 0.1))
       (r (SinOsc ar 440 0)))
  (audition (Out 0 (mce2 (Mul (Done e) l)
			 (Mul e r)))))
