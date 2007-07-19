;; (PitchShift in winSize pchRatio pchDispersion timeDispersion)

;; A simple time domain pitch shifter.

(PitchShift (SinOsc ar 440 0) 
	    0.2
	    (MouseX kr 0.5 2 0 0.1)
	    (MouseY kr 0 0.1 0 0.1)
	    0)
