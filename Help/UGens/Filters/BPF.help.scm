;; (BPF in freq rq) 

;; Second order Butterworth bandpass filter

;; in    - input signal to be processed
;; freq  - cutoff frequency in Hertz.
;; rq    - the reciprocal of Q.  bandwidth / cutoffFreq. 

(let* ((f1 (XLine kr 0.7 300 20 removeSynth))
       (f2 (MulAdd (FSinOsc kr f1 0) 3600 4000)))
  (audition (Out 0 (BPF (Mul (Saw ar 200) 0.25) f2 0.3))))

(let* ((f1 (MouseX kr 220 440 0 0.1))
       (f2 (Mce f1 (Sub 550 f1)))
       (rq (MouseY kr 0 0.01 0 0.1)))
  (audition (Out 0 (BPF (WhiteNoise ar) f2 rq))))
