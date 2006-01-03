;; (PauseSelfWhenDone src)

;; Pause the synth when the 'done' flag of the unit at `src' is set.

(let ((env (Linen kr (MouseX kr -1 1) 1 0.1 1 doneAction: pauseSynth)))
  (SinOsc ar 440 0 env))

(let ((env (Linen kr (MouseX kr -1 1) 2 0.1 2 doneAction: doNothing)))
  (PauseSelfWhenDone kr env)
  (SinOsc ar 440 0 env))

