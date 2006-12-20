;; (Clip2 a b)

;; Bilateral clipping.  Clips a to +/- b

(Clip2 (FSinOsc ar 400 0) 0.2)

(Clip2 (FSinOsc ar 400 0) (Line kr 0 1 8 removeSynth))
