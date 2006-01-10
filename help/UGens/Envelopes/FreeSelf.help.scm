;; (FreeSelf src)

;; Free enclosing synth when the input signal `src' crosses from
;; non-positive to positive.

(begin (FreeSelf (MouseX kr -1 1 0 0.1))
       (Mul (SinOsc ar 440 0) 0.1))
