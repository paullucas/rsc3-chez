;; (FreeSelfWhenDone src)

;; Free the synth when the 'done' flag of the unit at `src' is set.

(let ((env (Linen (MouseX kr -1 1 0 0.1) 1 0.1 1 removeSynth)))
  (Mul (SinOsc ar 440 0) env))

(let ((env (Linen (MouseX kr -1 1 0 0.1) 2 0.1 2 doNothing)))
  (Mrg (FreeSelfWhenDone env)
       (Out 0 (Mul (SinOsc ar 440 0) env))))
