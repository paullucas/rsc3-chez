;; (LT a b)

;; Less than to, written '<' in sclang.  

;; Signal is 1.0 if a < b, otherwise it is 0.0. This can be useful for
;; triggering purposes, among other things.

;; Trigger an envelope.

(let ((t (LT (SinOsc ar 1 0) 0)))
  (Mul (SinOsc ar 440 0)
       (EnvGen kr t 0.1 0 1 doNothing (env/perc 0.01 1 1 -4))))
