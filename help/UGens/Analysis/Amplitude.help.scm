;; (Amplitude rate in attackTime releaseTime) 

;; Amplitude follower. Tracks the peak amplitude of a signal.

(Mul (Pulse ar 90 0.3)
     (Amplitude kr (In 1 ar NumOutputBuses) 0.01 0.01))

(let* ((a (Amplitude kr (In 1 ar NumOutputBuses) 0.01 0.01))
       (f (MulAdd a 1200 400)))
  (Mul (SinOsc ar f 0) 0.3))
