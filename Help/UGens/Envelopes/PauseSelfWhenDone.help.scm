;; (PauseSelfWhenDone src)

;; Pause the synth when the 'done' flag of the unit at `src' is set.

(let* ((x (MouseX kr -1 1 0 0.1))
       (e (Linen x 1 0.1 1 pauseSynth)))
  (audition (Mul (SinOsc ar 440 0) e)))

(let* ((x (MouseX kr -1 1 0 0.1))
       (e (Linen x 2 0.1 2 doNothing)))
  (audition (Mrg (PauseSelfWhenDone e)
		 (Out 0 (Mul (SinOsc ar 440 0) e)))))
