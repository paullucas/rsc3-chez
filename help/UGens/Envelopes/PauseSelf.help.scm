;; (PauseSelf src)

;; Pause enclosing synth when input signal crosses from non-positive
;; to positive.  If the synth is restarted and the gate reset the
;; synthis *not* paused a second time.

(synthdef-send
 (synthdef
  "PauseSelf-Help"
  ((gate 0))
  (begin (PauseSelf kr gate)
	 (Out 0 (Mul (SinOsc ar 440 0) 0.1)))))

(define a (synth-new "PauseSelf-Help"))

(synth-set a 'gate 1)

(synth-run a #t)

(synth-free a)
