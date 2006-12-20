;; (DbAmp a)

;; Convert decibels to linear amplitude.

(Mul (FSinOsc ar 800 0.0)
     (DbAmp (Line kr -3 -40 10 removeSynth)))
