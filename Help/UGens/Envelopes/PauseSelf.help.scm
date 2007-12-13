;; (PauseSelf src)

;; Pause enclosing synth when input signal crosses from non-positive
;; to positive.  If the synth is restarted and the gate reset the
;; synthesis *not* paused a second time.

(audition
 (Mrg (PauseSelf (MouseX kr -1 1 0 0.1))
      (Out 0 (Mul (SinOsc ar 440 0) 0.1))))
