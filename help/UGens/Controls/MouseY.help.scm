;; (MouseY minval maxval warp lag)

;; Report mouse location on root window of the machine that the
;; synthesis server is running on.  For a linear mapping set warp to
;; 0, for an exponential mapping set warp to 1.

(Mul (SinOsc ar (MouseX kr 20 2000 0 0.1) 0)
     (MouseY kr 0.01 0.1 0 0.1))
