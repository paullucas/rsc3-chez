;; (In bus numChannels)

;; Read signal from an audio or control bus.
 
;; Patching input to output.

(Out 0 (In ar (NumInputBuses ir) 2))

;; Patching input to output, with delay.

(let ((i (In ar (NumInputBuses ir) 2)))
  (Out 0 (Add i (DelayN i 0.5 0.5))))

;; Write noise to bus 10, then read it out.  The Mrg is ordered.

(Mrg (Out 0 (In ar 10 1))
     (Out 10 (Mul (PinkNoise ar) 0.3)))

;; Reading a control bus.

(-> s (/c_set 0 (rand 200 5000)))

(Mul (SinOsc ar (In kr 0 1) 0) 0.1)

(at Q 
    (utc)
    (lambda (t f)
      (-> s (/c_set 0 (rand 200 5000)))
      (f 0.06)))
