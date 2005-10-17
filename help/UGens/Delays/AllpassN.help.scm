;; (AllpassN in maxDelayTime delayTime decayTime)

;; All pass delay line. AllpassN uses no interpolation, AllpassL uses
;; linear interpolation, AllpassC uses all pass interpolation.  All
;; time values are in seconds.  The decay time is the time for the
;; echoes to decay by 60 decibels. If this time is negative then the
;; feedback coefficient will be negative, thus emphasizing only odd
;; harmonics at an octave lower.

;; Since the allpass delay has no audible effect as a resonator on
;; steady state sound ... 

(AllpassC.ar (WhiteNoise.ar 0.1) 0.01 (XLine.kr 0.0001 0.01 20) 0.2)

;; ...these examples add the input to the effected sound so that you
;; can hear the effect of the phase comb.

(let ((z (WhiteNoise.ar 0.1)))
  (Add z (AllpassN.ar z 0.01 (XLine.kr 0.0001 0.01 20) 0.2)))

(let ((z (WhiteNoise.ar 0.1)))
  (Add z (AllpassL.ar z 0.01 (XLine.kr 0.0001 0.01 20) 0.2)))

(let ((z (WhiteNoise.ar 0.1)))
  (Add z (AllpassC.ar z 0.01 (XLine.kr 0.0001 0.01 20) 0.2)))

;; Used as an echo - doesn't really sound different than Comb, but it
;; outputs the input signal immediately (inverted) and the echoes are
;; lower in amplitude.

(AllpassN.ar (Decay.ar (Dust.ar 1 0.5) 0.2 (WhiteNoise.ar)) 0.2 0.2 3)
