;;; (Out bufferIndex inputs)				

;; Send signal to an audio or control buss, mix with existing signal.
;; The user is responsible for making sure that the number of channels
;; match and that there are no conflicts.

(begin (Out.ar 0 (SinOsc.ar '(330 331) 0 0.1))
       (SinOsc.ar '(120 121) 0 0.1))
