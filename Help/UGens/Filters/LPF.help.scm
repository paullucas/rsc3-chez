;; (LPF in freq)

;; Second order Butterworth lowpass filter.

(LPF (Mul (Saw ar 200) 0.1)
     (MulAdd (FSinOsc kr (XLine kr 0.7 300 20 removeSynth) 0) 3600 4000))
