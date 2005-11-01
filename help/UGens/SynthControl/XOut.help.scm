;; (XOut bufferIndex xfade inputs)				 
 
;; Send signal to a bus, crossfading with existing contents.
 
(begin (Out.ar 0 (SinOsc.ar '(220 221) 0 0.1))
       (XOut.ar 0 (MouseX.kr) (SinOsc.ar '(330 331) 0 0.1))
       (XOut.ar 0 (MouseY.kr) (SinOsc.ar '(440 441) 0 0.1))
       (SinOsc.ar '(120 121) 0 0.05))
