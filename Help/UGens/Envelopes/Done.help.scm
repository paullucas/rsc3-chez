;; (Done src)

;; Outputs a unit signal if the 'done' flag of the unit at `src' is
;; set, else output zero.

(let ((env (Linen (MouseX kr -1 1 0 0.1) 0.1 0.1 0.5 doNothing)))
  (Mce (Mul (Done env) (Mul (SinOsc ar 880 0) 0.1))
       (Mul (SinOsc ar 440 0) env)))
