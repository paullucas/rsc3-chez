;; (FreeSelf src)

;; Free enclosing synth when the input signal `src' crosses from
;; non-positive to positive.

(Mrg (FreeSelf (MouseX kr -1 1 0 0.1))
     (Out 0 (Mul (SinOsc ar 440 0) 0.1)))
