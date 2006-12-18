;; (Amplitude rate in attackTime releaseTime) 

;; Amplitude follower. Tracks the peak amplitude of a signal.

(Mul (Pulse ar 90 0.3)
     (Amplitude kr (In 1 ar (NumInputBuses ir)) 0.01 0.01))

(Mul (SinOsc ar (MulAdd (Amplitude kr (In 1 ar (NumInputBuses ir)) 0.01 0.01) 
			1200 400) 
	     0)
     0.3)
