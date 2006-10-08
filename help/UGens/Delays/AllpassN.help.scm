;; (AllpassN in maxDelayTime delayTime decayTime)

;; All pass delay line. AllpassN uses no interpolation, AllpassL uses
;; linear interpolation, AllpassC uses all pass interpolation.  All
;; time values are in seconds.  The decay time is the time for the
;; echoes to decay by 60 decibels. If this time is negative then the
;; feedback coefficient will be negative, thus emphasizing only odd
;; harmonics at an octave lower.

;; Since the allpass delay has no audible effect as a resonator on
;; steady state sound ...

(define z (Mul (WhiteNoise ar) 0.1))

(AllpassC z 0.01 (XLine kr 0.0001 0.01 20 doNothing) 0.2)

;; ...these examples add the input to the effected sound so that you
;; can hear the effect of the phase comb.

(Add z (AllpassN z 0.01 (XLine kr 0.0001 0.01 20 doNothing) 0.2))

(Add z (AllpassL z 0.01 (XLine kr 0.0001 0.01 20 doNothing) 0.2))

(Add z (AllpassC z 0.01 (XLine kr 0.0001 0.01 20 doNothing) 0.2))

;; Used as an echo - doesn't really sound different than Comb, but it
;; outputs the input signal immediately (inverted) and the echoes are
;; lower in amplitude.

(AllpassN (Mul (Decay (Dust ar 1) 0.2) z) 0.2 0.2 3)
