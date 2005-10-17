;;; (Pan2 in pos level)

;;; Two channel equal power panner.  The pan position is bipolar, -1
;;; is left, +1 is right.  The level is a control rate input.

(Pan2.ar (PinkNoise.ar) (FSinOsc.kr 2) 0.3)

(Pan2.ar (PinkNoise.ar) (MouseX.kr -1 1) (MouseY.kr 0 1))
