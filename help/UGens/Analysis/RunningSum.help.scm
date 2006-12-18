;; (RunningSum in numsamp)

;; A running sum over a user specified number of samples, useful for
;; running RMS power windowing.

;; in      - Input signal
;; numsamp - How many samples to take the running sum over 
;;           (initialisation rate)

(let ((n 40))
  (Mul* (SinOsc ar 440 0)
	(RunningSum (audioin (Mce 1 2)) n)
	(Recip n)))
