;;; (Done src)

;;; Outputs a unit signal if the 'done' flag of the unit at `src' is
;;; set, else output zero.

(let ((env (Linen.kr (MouseX.kr -1 1) 1 0.1 1 doneAction: doNothing)))
  (list (Mul (Done.kr env) (SinOsc.ar 880 0 0.1))
	(SinOsc.ar 440 0 env)))
