;; (Rand lo hi)

;; Generates a single random value in uniform distribution from lo to
;; hi.  It generates this when the SynthDef first starts playing, and
;; remains fixed for the duration of the synth's existence.
 
(Pan2.ar (FSinOsc.ar (Rand.ir 200 1200) 0 (Line.kr 0.2 0 0.1 'doneAction: 2))
	 (Rand.ir -1 1))
