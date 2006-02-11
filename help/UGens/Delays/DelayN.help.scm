;; (DelayN in maxDelayTime delayTime)
;; (DelayL in maxDelayTime delayTime)
;; (DelayA in maxDelayTime delayTime)

;; Simple delay line.  There are three forms, DelayN uses no
;; interpolation, DelayL uses linear interpolation, DelayA uses all
;; pass interpolation.  The maximum delay length is set at
;; initialization time and cannot be extended.

;; Dust randomly triggers Decay to create an exponential decay
;; envelope for the WhiteNoise input source.

(let ((z (Mul (Decay (Dust R0 ar 1) 0.3)
	      (WhiteNoise R0 ar))))
  (Add (DelayN z 0.2 0.2) z))
