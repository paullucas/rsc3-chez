;; (LagIn numChannels bus lag)

;; Smooth a control rate input signal.

(Mul (SinOsc ar (LagIn 1 10 1) 0) 0.1)

;; Set bus 10.

(-> s (/c_set 10 (rand 200 8000)))
