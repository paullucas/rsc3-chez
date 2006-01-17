;; (Timer trig)

;; Returns time since last triggered
	
;; Using timer to modulate sine frequency: the slower the trigger is
;; the higher the frequency

(let ((t (Impulse kr (MouseX kr 0.5 20 1 0.1) 0)))
  (Mul (SinOsc ar (MulAdd (Timer t) 500 500) 0)
       0.2))
