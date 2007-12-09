;; (LFClipNoise rate freq)

;; Randomly generates the values -1 or +1 at a rate given by the
;; nearest integer division of the sample rate by the freq argument.
;; It is probably pretty hard on your speakers.  The freq argument is
;; the approximate rate at which to generate random values.
 
(audition (Out 0 (Mul (LFClipNoise ar 1000) 0.1)))

;; Modulate frequency 

(let ((f (XLine kr 1000 10000 10 removeSynth)))
  (audition (Out 0 (Mul (LFClipNoise ar f) 0.1))))

;; Use as frequency control 

(let ((f (MulAdd (LFClipNoise kr 4) 200 600)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.2))))
