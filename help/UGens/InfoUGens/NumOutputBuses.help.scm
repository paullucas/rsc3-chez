;; NumOutputBuses

;; The number of audio buses allocated to output.

(let ((bus NumOutputBuses))
  (Mul (Pulse ar 90 0.3)
       (Amplitude kr (Lag (In 1 ar bus) 0.1) 0.01 0.01)))
