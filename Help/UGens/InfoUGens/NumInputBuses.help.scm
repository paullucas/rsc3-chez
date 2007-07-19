;; NumInputBuses

;; The number of audio buses allocated to input.  Input buses follow
;; output buses which begin at zero.

(let ((bus (Add NumOutputBuses NumInputBuses)))
  (Mrg (Out 0 (In 1 ar bus))
       (Out bus (Mul (SinOsc ar 440 0) 0.1))))
