;; (Demand trig reset ugens)

;; Demand results from demand rate ugens.

;; When there is a trigger at the trig input, a value is demanded each
;; ugen in the list and output. The unit generators in the list should
;; be 'demand' rate.

;; When there is a trigger at the reset input, the demand rate ugens
;; in the list are reset.

;; trig - trigger. Trigger can be any signal. A trigger happens when
;;                 the signal changes from non-positive to positive.

;; reset - trigger. Resets the list of ugens when triggered.

(let* ((trig (Impulse kr 24))
       (seq (Drand dr 2000
		      (list (Dseq dr 1 (mirror1 (iota 5 1)))
			    (Drand dr 8 (iota 7 4)))))
       (freq (Demand kr trig 0 (Mul seq 100))))
  (Mul (ScaleNeg (Cubed (Cubed (SinOsc ar (list freq (Add freq 0.7)))))
		 (MouseX kr -1 1))
       0.1))

(let* ((trig (Impulse kr 10))
       (reset (Dust kr 1))
       (seq (Dgeom dr 24 (MIDICPS 72) (MIDIRatio 1)))
       (freq (Demand kr trig reset seq)))
  (Mul (Max (Cubed (SinOsc ar (list freq (Add freq 0.7)))) 0) 0.1))

(let* ((trig (Impulse kr 10))
       (seq (MIDICPS (Diwhite dr 1 60 72)))
       (freq (Demand kr trig 0 seq)))
  (Mul (Cubed (Cubed (SinOsc ar (list freq (Add freq 0.7))))) 0.1))
