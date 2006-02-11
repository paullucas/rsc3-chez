;; (CombN in maxDelayTime delayTime decayTime)
;; (CombL in maxDelayTime delayTime decayTime)
;; (CombC in maxDelayTime delayTime decayTime)

;; Comb delay line. CombN uses no interpolation, CombL uses linear
;; interpolation, CombC uses all pass interpolation.  All times are in
;; seconds.  The decay time is the time for the echoes to decay by 60
;; decibels. If this time is negative then the feedback coefficient
;; will be negative, thus emphasizing only odd harmonics at an octave
;; lower.

;; Comb used as a resonator. The resonant fundamental is equal to
;; reciprocal of the delay time.

(define src (Mul (WhiteNoise R0 ar) 0.01))

(define ctl (XLine kr 0.0001 0.01 20 2))

(CombN src 0.01 ctl 0.2)

(CombL src 0.01 ctl 0.2)

(CombC src 0.01 ctl 0.2)

;; With negative feedback:

(CombN src 0.01 ctl -0.2)

(CombL src 0.01 ctl -0.2)

(CombC src 0.01 ctl -0.2)

;; Used as an echo.

(CombN (Mul (Decay (Mul (Dust R0 ar 1) 0.5) 0.2) (WhiteNoise R0 ar))
       0.2 0.2 3)
