;; (EnvGen gate levelScale levelBias timeScale doneAction envelope)

;; A segment based envelope generator.  Note that the SC3 language
;; reorders the inputs to this UGen so that the envelope is the first
;; argument.

(Mul (EnvGen.kr envelope: (Env.perc)
		gate: 1.0 
		doneAction: 2)
     (SinOsc.ar 440 0 0.1))

;; The break-point assistant makes a static envelope from a
;; co-ordinate list.  There is a duration and amplitude scalar.

(Mul (EnvGen.kr envelope: (Env.bp '(0 0 1/2 1 1 0))
		gate: 1.0 
		doneAction: 2)
     (SinOsc.ar 440 0 0.1))

