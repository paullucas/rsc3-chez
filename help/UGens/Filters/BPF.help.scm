;; (BPF in freq rq) 

;; Second order Butterworth bandpass filter

;; in    - input signal to be processed
;; freq  - cutoff frequency in Hertz.
;; rq    - the reciprocal of Q.  bandwidth / cutoffFreq. 

(BPF (Mul (Saw ar 200) 0.5) 
     (MulAdd (FSinOsc kr (XLine kr 0.7 300 20 removeSynth) 0) 3600 4000) 
     0.3)

(let ((f (MouseX kr 220 440 0 0.1))) 
  (BPF (WhiteNoise ar)
       (Mce f (Sub 550 f))
       (MouseY kr 0 0.01 0 0.1)))
