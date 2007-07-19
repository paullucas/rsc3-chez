;; (HPF in freq)

;; Second order Butterworth highpass filter.

(Mul (HPF (Mul (Saw ar 200) 0.1)
	  (MulAdd (FSinOsc kr (XLine kr 0.7 300 20 doNothing) 0) 3600 4000))
     5)
