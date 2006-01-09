;; (Demand trig reset ugens)

;; Demand results from demand rate ugens.

;; When there is a trigger at the trig input, a value is demanded from
;; each ugen in the list and output. The unit generators in the list
;; should be 'demand' rate.

;; When there is a trigger at the reset input, the demand rate ugens
;; in the list are reset.

;; trig - trigger. Trigger can be any signal. A trigger happens when
;;                 the signal changes from non-positive to positive.

;; reset - trigger. Resets the list of ugens when triggered.

(let* ((trig (Impulse kr 24 0))
       (seq (Drand inf (Mce (Dseq 1 (Mce* (mirror1 (iota 5 1))))
			    (Drand 8 (Mce* (iota 7 4))))))
       (freq (Demand trig 0 (Mul seq 100))))
  (Mul (ScaleNeg (Cubed (Cubed (SinOsc ar (Mce freq (Add freq 0.7)) 0)))
		 (MouseX kr -1 1 0 0.1))
       0.1))

(let* ((trig (Impulse kr 10 0))
       (reset (Dust 0 kr 1))
       (seq (Dgeom inf (midicps 72) (midiratio 1)))
       (freq (Demand trig reset seq)))
  (Mul (Max (Cubed (SinOsc ar (Mce freq (Add freq 0.7)) 0)) 0) 0.1))

(let* ((trig (Impulse kr 10 0))
       (seq (MIDICPS (Diwhite inf 60 72)))
       (freq (Demand trig 0 seq)))
  (Mul (Cubed (Cubed (SinOsc ar (Mce freq (Add freq 0.7)) 0))) 0.1))
