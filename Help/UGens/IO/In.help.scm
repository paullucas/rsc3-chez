;; (In numChannels rate bus)

;; Read signal from an audio or control bus.
 
;; Patching input to output.

(audition (Out 0 (In 2 ar NumOutputBuses)))

;; Patching input to output, with summed delay.

(let ((i (In 2 ar NumInputBuses)))
  (audition (Out 0 (Add i (DelayN i 0.5 0.5)))))

;; Write noise to bus 10, then read it out.  The Mrg is ordered.

(audition (Mrg (Out 0 (In 1 ar 10))
	       (Out 10 (Mul (PinkNoise ar) 0.3))))

;; Reading a control bus.

(with-sc3 (lambda (fd) (-> fd (/c_set 0 (rand 200 5000)))))

(audition (Out 0 (Mul (SinOsc ar (In 1 kr 0) 0) 0.1)))

(with-sc3 
 (lambda (fd) 
   (at Q 
       (utc)
       (lambda (t f)
	 (-> fd (/c_set 0 (rand 200 5000)))
	 (f 0.06)))
   (sleep 4)
   (schedule-clear Q)))
