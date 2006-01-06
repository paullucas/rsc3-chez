;; (LastValue in diff) 			 
 
;; Output the last value before the input changed more than a
;; threshhold.
 
(Mul (SinOsc ar (LastValue (MouseX kr 100 400 0 0.1) 40) 0) 0.1)

(let ((value (MouseX kr 0.1 4 0 0.1)))
  (Mul (SinOsc ar (MulAdd (Abs (Sub value (LastValue value 0.5))) 400 200) 0)
       0.2))
