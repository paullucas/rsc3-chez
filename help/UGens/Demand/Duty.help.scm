;; (Duty rate duration reset doneAction level)

;; Demand results from demand rate ugens

;; A value is demanded from each ugen in the list and output according
;; to a stream of duration values.  The unit generators in the list
;; should be 'demand' rate.  When there is a trigger at the reset
;; input, the demand rate ugens in the list and the duration are
;; reset.  The reset input may also be a demand ugen, providing a
;; stream of reset times.

;; duration: time values. Can be a demand ugen or any signal.  The
;; next value is acquired after the duration provided by the last time
;; value.
		
;; reset: trigger or reset time values. Resets the list of ugens and
;; the duration ugen when triggered.  The reset input may also be a
;; demand ugen, providing a stream of reset times.

;; doneAction: a doneAction that is evaluated when the duration stream
;; ends.

;; level: demand ugen providing the output values.

(let ((freq (Duty kr
		  (Drand +inf.sc (Mce 0.01 0.2 0.4))
		  0
		  2
		  (Dseq +inf.sc (Mce 204 400 201 502 300 200)))))
  (Mul (SinOsc ar (Mul freq (Mce 1 1.01)) 0) 0.1))

(let ((freq (Duty kr
		  (MouseX kr 0.001 2 1 0.1)
		  0
		  2
		  (Dseq +inf.sc (Mce 204 400 201 502 300 200)))))
  (Mul (SinOsc ar (Mul freq (Mce 1 1.0)) 0) 0.1))
