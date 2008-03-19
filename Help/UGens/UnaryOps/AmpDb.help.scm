;; (AmpDb a)

;; Convert linear amplitude to decibels.

(mul (fsin-osc ar 800 0.0)
     (DbAmp (AmpDb (line kr 0.5 0.0 5 remove-synth))))

(let* ((x (mouse-x kr -60 0 0 0.1))
       (f (mul-add (DbAmp x) 600 900)))
  (mul (sin-osc ar f 0) 0.1))
