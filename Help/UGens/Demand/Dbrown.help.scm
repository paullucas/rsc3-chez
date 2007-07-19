;; (Dbrown  length lo hi step)
;; (Dibrown length lo hi step)

;; Demand rate brownian movement generators.

;; lo		minimum value
;; hi 		maximum value
;; step		maximum step for each new value
;; length	number of values to create

;; Dbrown returns numbers in the continuous range between lo and hi,
;; Dibrown returns integer values.  The arguments can be a number or
;; any other ugen.

(let ((f (lambda (u)
	   (let* ((a (u +inf.sc 0 15 1))
		  (t (Impulse kr (MouseX kr 1 40 1 0.1) 0))
		  (f (MulAdd (Demand t 0 a) 30 340)))
	     (Mul (SinOsc ar f 0) 0.1)))))
  (Mce (f Dbrown)
       (f Dibrown)))
