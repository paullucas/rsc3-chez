;; (MouseY minval maxval warp lag)

;; Report mouse location on root window of the machine that the
;; synthesis server is running on.

(SinOsc.ar (MouseX.kr 20 2000 0 0.1) 
	   0 
	   (MouseY.kr 0.01 0.1 0 0.1))
