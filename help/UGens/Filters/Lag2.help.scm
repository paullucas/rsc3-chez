;; (Lag2 in lagTime)

;; Lag2 is the same as (Lag kr (Lag kr in time) time).

(let ((x (MouseX kr 220 440)))
  (SinOsc ar (list x (Lag2 kr x 1)) 0 0.1))
