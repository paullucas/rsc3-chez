;; (In numChannels rate bus)

;; Read signal from an audio or control bus.
 
;; Patching input to output.

(Out 0 (In 2 ar NumOutputBuses))

;; Patching input to output, with delay.

(let ((i (In 2 ar NumInputBuses)))
  (Out 0 (Add i (DelayN i 0.5 0.5))))

;; Write noise to bus 10, then read it out.  The Mrg is ordered.

(Mrg (Out 0 (In 1 ar 10))
     (Out 10 (Mul (PinkNoise ar) 0.3)))

;; Reading a control bus.

(-> s (/c_set 0 (rand 200 5000)))

(Mul (SinOsc ar (In 1 kr 0) 0) 0.1)

(at Q 
    (utc)
    (lambda (t f)
      (-> s (/c_set 0 (rand 200 5000)))
      (f 0.06)))
