;; (Amplitude rate in attackTime releaseTime) 

;; Amplitude follower. Tracks the peak amplitude of a signal.

(mul (pulse ar 90 0.3)
     (Amplitude kr (in 1 ar NumoutputBuses) 0.01 0.01))

(let* ((a (Amplitude kr (in 1 ar NumoutputBuses) 0.01 0.01))
       (f (mul-add a 1200 400)))
  (mul (sin-osc ar f 0) 0.3))
