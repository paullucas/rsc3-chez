;; (MouseX minval maxval warp lag) - Cursor UGen

;; Report mouse location on root window of the machine that the
;; synthesis server is running on.

(SinOsc.ar (MouseX.kr 40 10000 1) 0 0.1)

(list (SinOsc.ar (MouseX.kr 20 2000 1 0.1) 
		 0 
		 (MouseY.kr 0.01 0.1 0 0.1))
      (SinOsc.ar (MouseY.kr 20 2000 1 0.1) 
		 0 
		 (MouseX.kr 0.01 0.1 0 0.1)))
