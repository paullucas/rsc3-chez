;; (FreeSelf src)

;; Free enclosing synth when the input signal `src' crosses from
;; non-positive to positive.

(begin (FreeSelf.kr (MouseX.kr -1 1))
       (SinOsc.ar 440 0 0.1))
