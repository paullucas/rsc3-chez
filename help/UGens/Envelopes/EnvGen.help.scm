;; (EnvGen gate levelScale levelBias timeScale doneAction envelope)

;; A segment based envelope generator.  Note that the SC3 language
;; reorders the inputs to this UGen so that the envelope is the first
;; argument.

(Mul (EnvGen kr 1 0.1 0 1 2 (env/perc 0.01 1 1 -4))
     (SinOsc ar 440 0))

;; The break-point assistant makes a static envelope from a
;; co-ordinate list.  There is a duration and amplitude scalar.

(Mul (EnvGen kr 1 0.1 0 1 2 (env/bp '(0 0 1/2 1 1 0) 1 1))
     (SinOsc ar 440 0))
