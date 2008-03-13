;; (RunningSum in numsamp)

;; A running sum over a user specified number of samples, useful for
;; running RMS power windowing.

;; in      - Input signal
;; numsamp - How many samples to take the running sum over 
;;           (initialisation rate)

(let ((n 40))
  (audition
   (Out 0 (foldl1 Mul (list (SinOsc ar 440 0)
			    (RunningSum (audio-in (mce2 1 2)) n)
			    (Recip n))))))
