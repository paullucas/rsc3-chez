;; (LastValue in diff) 			 
 
;; Output the last value before the input changed more than a
;; threshhold.
 
(let ((f (LastValue (MouseX kr 100 400 0 0.1) 40)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.1))))

(let* ((x (MouseX kr 0.1 4 0 0.1))
       (f (MulAdd (Abs (Sub x (LastValue x 0.5))) 400 200)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.2))))
