;; (Rand lo hi)

;; Generates a single random value in uniform distribution from lo to
;; hi.  It generates this when the SynthDef first starts playing, and
;; remains fixed for the duration of the synth's existence.

(let* ((a (Line kr 0.2 0 0.1 2))
       (p (Rand -1 1))
       (s (Mul (FSinOsc ar (Rand 200 1200) 0) a)))
  (audition (Out 0 (Pan2 s p 1))))
