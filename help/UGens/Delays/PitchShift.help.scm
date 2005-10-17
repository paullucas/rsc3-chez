;;; (PitchShift in winSize pchRatio pchDispersion timeDispersion)

;;; A simple time domain pitch shifter.

(PitchShift.ar (SinOsc.ar 440) 0.2 (MouseX.kr 0.5 2) (MouseY.kr 0 0.1))
