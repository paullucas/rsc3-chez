;; (LastValue in diff) 			 
 
;; Output the last value before the input changed more than a
;; threshhold.
 
(SinOsc ar (LastValue ar (MouseX kr 100 400) 40) 0 0.1)

(let ((value (MouseX kr 0.1 4)))
  (SinOsc ar (Add kr (Mul kr (Abs kr (Sub kr value (LastValue kr value 0.5))) 400) 200) 0 0.2))
