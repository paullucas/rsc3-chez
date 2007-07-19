;; (TDelay trigger delayTime)

;; Delays a trigger by a given time. Any triggers which arrive in the
;; time between an input trigger and its delayed output, are ignored.

;; trigger   - input trigger signal.
;; delayTime - delay time in seconds.

(let ((z (Impulse ar 2 0)))
  (Mce (Mul z 0.1)
       (Mul (ToggleFF (TDelay z 0.5)) (Mul (SinOsc ar 440 0) 0.1))))
