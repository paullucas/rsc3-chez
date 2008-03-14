;; (GT a b)

;; Greater than, written '>' in sclang.  Signal is 1.0 if a > b,
;; otherwise it is 0.0. Similarly LT is <, GE >=, LE <= and EQ ==.
;; These can be useful for triggering purposes, among other things.

(let* ((o (SinOsc kr 1 0))
       (t (list (GT o 0)
		(GE o 0)
		(LT o 0)
		(LE o 0)
		(EQ o 0)
		(Mul (LT o 0.001) (GT o -0.001))))
       (f (list 220
		330
		440
		550
		660
		770))
       (p (env/perc 0.01 1 1 (list -4 -4)))
       (e (EnvGen kr (make-mce t) 0.1 0 1 doNothing p)))
  (audition (Out 0 (mix (Mul (SinOsc ar (make-mce f) 0) e)))))
