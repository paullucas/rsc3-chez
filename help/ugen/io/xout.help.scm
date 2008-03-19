;; (Xout bufferindex xfade inputs)				 
 
;; Send signal to a bus, crossfading with existing contents.

(let ((pair (lambda (a b) (mul (sin-osc ar (Mce a b) 0) 0.1))))
  (audition
   (Mrg (out  0 (pair 220 221))
	(Xout 0 (mouse-x kr 0 1 0 0.1) (pair 330 331))
	(Xout 0 (mouse-y kr 0 1 0 0.1) (pair 440 441))
	(out  0 (pair 120 121)))))
