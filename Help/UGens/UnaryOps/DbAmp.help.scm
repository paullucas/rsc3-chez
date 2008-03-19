;; (DbAmp a)

;; Convert decibels to linear amplitude.

(mul (fsin-osc ar 800 0.0)
     (DbAmp (line kr -3 -40 10 remove-synth)))
