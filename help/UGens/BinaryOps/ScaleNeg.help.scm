;; (ScaleNeg a b)

;; Scale negative part of input wave.  a * b when a < 0, otherwise a.

(ScaleNeg (FSinOsc.ar 500) (Line.ar 1 -1 4))

