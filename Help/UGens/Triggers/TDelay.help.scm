;; (TDelay trigger delayTime)

;; Delays a trigger by a given time. Any triggers which arrive in the
;; time between an input trigger and its delayed output, are ignored.

;; trigger   - input trigger signal.
;; delayTime - delay time in seconds.

(let* ((s (Mul (SinOsc ar 440 0) 0.1))
       (z (Impulse ar 2 0))
       (l (Mul z 0.1))
       (r (Mul (ToggleFF (TDelay z 0.5)) s)))
  (audition (Out 0 (Mce l r))))
