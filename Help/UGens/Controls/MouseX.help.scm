;; (MouseX rate minval maxval warp lag)

;; Cursor UGen.  Report mouse location on root window of the machine
;; that the synthesis server is running on.  For a linear mapping set
;; warp to 0, for an exponential mapping set warp to 1.

(audition
 (Out 0 (Mul (SinOsc ar (MouseX kr 40 10000 1 0.1) 0) 0.1)))

(audition
 (Out 0 (mce2 (Mul (SinOsc ar (MouseX kr 20 2000 1 0.1) 0)
		   (MouseY kr 0.01 0.1 0 0.1))
	      (Mul (SinOsc ar (MouseY kr 20 2000 1 0.1) 0)
		   (MouseX kr 0.01 0.1 0 0.1)))))
