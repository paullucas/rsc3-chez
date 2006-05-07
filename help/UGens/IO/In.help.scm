;; (In bus numChannels)

;; Read signal from an audio or control bus.
 
;; Patching input to output

(Out 0 (In ar (NumInputBuses ir) 2))

;; Write noise to bus 10, then read it out.

(Mrg (Out 10 (Mul (PinkNoise ar) 0.3))
     (Out 0 (In ar 10 1)))

;; Reading a control bus.

(-> s (/c_set 0 (rand 200 5000)))

(Mul (SinOsc ar (In kr 0 1) 0) 0.1)
