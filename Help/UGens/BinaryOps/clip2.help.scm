;; (clip2 a b)

;; Bilateral clipping.  clips a to +/- b

(clip2 (fsin-osc ar 400 0) 0.2)

(clip2 (fsin-osc ar 400 0) (line kr 0 1 8 remove-synth))
