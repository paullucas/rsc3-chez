;; (Amplitude in attackTime releaseTime) 

;; Amplitude follower. Tracks the peak amplitude of a signal.

(Pulse ar 90 0.3 (Amplitude kr (In ar 2)))

(SinOsc ar (Amplitude kr (In ar 2) 0.01 0.01 1200 400) 0 0.3)
