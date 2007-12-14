;; (pm-osc rate carfreq modfreq index modphase)

;; Phase modulation oscillator pair.

;; carfreq - carrier frequency in cycles per second.
;; modfreq - modulator frequency in cycles per second.
;; index - modulation index in radians.
;; modphase - a modulation input for the modulator's phase in radians

(let* ((f (Line kr 600 900 5 removeSynth))
       (o (Mul (pm-osc ar f 600 3 0) 0.1)))
  (audition (Out 0 o)))

(let* ((mf (Line kr 600 900 5 removeSynth))
       (o (Mul (pm-osc ar 300 mf 3 0) 0.1)))
  (audition (Out 0 o)))

(let* ((i (Line kr 0 20 8 removeSynth))
       (o (Mul (pm-osc ar 300 550 i 0) 0.1)))
  (audition (Out 0 o)))
