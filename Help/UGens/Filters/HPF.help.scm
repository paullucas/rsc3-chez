;; (HPF in freq)

;; Second order Butterworth highpass filter.

(let* ((i (Mul (Saw ar 200) 0.1))
       (f1 (XLine kr 0.7 300 20 doNothing))
       (f2 (MulAdd (FSinOsc kr f1 0) 3600 4000)))
  (audition (Out 0 (Mul (HPF i f2) 5))))
