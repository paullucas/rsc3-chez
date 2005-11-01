;; (Lag2 in lagTime)

;; Lag3 is the same as (Lag.kr (Lag.kr (Lag.kr in time) time) time).

(let ((x (MouseX.kr 220 440)))
  (SinOsc.ar (list x (Lag3.kr x 1)) 0 0.1))
