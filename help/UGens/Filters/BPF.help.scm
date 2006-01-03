;; (BPF in freq rq) 

;; Second order Butterworth bandpass filter

;; in    - input signal to be processed
;; freq  - cutoff frequency in Hertz.
;; rq    - the reciprocal of Q.  bandwidth / cutoffFreq. 

(BPF ar (Saw ar 200 0.5) (FSinOsc kr (XLine kr 0.7 300 20) 0 3600 4000) 0.3)

(let ((f (MouseX kr 220 440))) 
  (BPF ar (WhiteNoise ar) (list f (-u 550 f)) (MouseY kr 0 0.01)))
