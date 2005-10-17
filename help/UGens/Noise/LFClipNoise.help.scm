;; (LFClipNoise freq)

;; Randomly generates the values -1 or +1 at a rate given by the
;; nearest integer division of the sample rate by the freq argument.
;; It is probably pretty hard on your speakers.  The freq argument is
;; the approximate rate at which to generate random values.
 
(LFClipNoise.ar 1000 0.25)

;; Modulate frequency 

(LFClipNoise.ar (XLine.kr 1000 10000 10) 0.25)

;; Use as frequency control 

(SinOsc.ar (LFClipNoise.kr 4 200 600) 0 0.2)
