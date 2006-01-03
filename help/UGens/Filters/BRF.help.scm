;; (BRF in freq rq) 

;; Second order Butterworth band reject filter.

(BRF ar (Saw ar 200 0.1) (FSinOsc kr (XLine kr 0.7 300 20) 0 3800 4000) 0.3)


