;; NumoutputBuses

;; The number of audio buses allocated to output.

(let ((bus NumoutputBuses))
  (mul (pulse ar 90 0.3)
       (Amplitude kr (lag (in 1 ar bus) 0.1) 0.01 0.01)))
