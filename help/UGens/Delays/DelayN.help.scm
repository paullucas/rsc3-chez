;; (DelayN in maxDelayTime delayTime)

;; Simple delay line.  There are three forms, DelayN uses no
;; interpolation, DelayL uses linear interpolation, DelayA uses all
;; pass interpolation.  The maximum delay length is set at
;; initialization time and cannot be extended.

;; Dust randomly triggers Decay to create an exponential decay
;; envelope for the WhiteNoise input source.  The input is mixed with
;; delay via the add input.

(let ((z (Decay.ar (Dust.ar 1 1) 0.3 (WhiteNoise.ar))))
  (DelayN.ar z 0.2 0.2 1 z))
