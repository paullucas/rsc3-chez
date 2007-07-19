;; (XOut bufferIndex xfade inputs)				 
 
;; Send signal to a bus, crossfading with existing contents.

(define (pair a b) (Mul (SinOsc ar (Mce a b) 0) 0.1))

(Mrg (Out  0 (pair 220 221))
     (XOut 0 (MouseX kr 0 1 0 0.1) (pair 330 331))
     (XOut 0 (MouseY kr 0 1 0 0.1) (pair 440 441))
     (Out  0 (pair 120 121)))
