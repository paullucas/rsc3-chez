;; (TWindex in normalize array)

;; Triggered windex.  When triggered, returns a random index value
;; based on array as a list of probabilities.  By default the list of
;; probabilities should sum to 1.0, when the normalize flag is set to
;; 1, the values get normalized by the ugen (less efficient)
 
;; Assuming normalized values 

(let ((prob (Mce 1/5 2/5 2/5))
      (freq (Mce 400 500 600)))
  (Mul (SinOsc ar (Select (TWindex (Impulse kr 6 0) 0.0 prob) freq) 0)
       0.2))

;; Modulating probability values 

(Mul (SinOsc ar (Select (TWindex (Impulse kr 6 0) 
				 1.0
				 (Mce 1/4 1/2 (MulAdd (SinOsc kr 0.3 0) 0.5 0.5)))
			(Mce 400 500 600)) 0)
     0.2)
