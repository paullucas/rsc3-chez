;; (AmpDb a)

;; Convert linear amplitude to decibels.

(Mul (FSinOsc ar 800 0.0)
     (DbAmp (AmpDb (Line kr 0.5 0.0 5 removeSynth))))

(let* ((x (MouseX kr -60 0 0 0.1))
       (f (MulAdd (DbAmp x) 600 900)))
  (Mul (SinOsc ar f 0) 0.1))
