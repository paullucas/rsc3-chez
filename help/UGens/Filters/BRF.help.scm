;; (BRF in freq rq) 

;; Second order Butterworth band reject filter.

(BRF (Mul (Saw ar 200) 0.1)
     (MulAdd (FSinOsc kr (XLine kr 0.7 300 20 removeSynth) 0) 3800 4000) 
     0.3)
