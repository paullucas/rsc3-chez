;; (BRF in freq rq) 

;; Second order Butterworth band reject filter.

(let* ((f1 (XLine kr 0.7 300 20 removeSynth))
       (f2 (MulAdd (FSinOsc kr f1 0) 3600 4000)))
  (audition (Out 0 (BRF (Mul (Saw ar 200) 0.1) f2 0.3))))
