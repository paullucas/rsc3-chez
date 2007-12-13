;; (EnvGen rate gate levelScale levelBias timeScale doneAction envelope)

;; A segment based envelope generator.  Note that the SC3 language
;; reorders the inputs to this UGen so that the envelope is the first
;; argument.

;; There are utilities for contructing the envelope argument.

;; The arguments for levelScale, levelBias, and timeScale are polled
;; when the EnvGen is triggered and remain constant for the duration
;; of the envelope.

;; envelope - an breakpoint set

;; gate - this triggers the envelope and holds it open while > 0. If
;;        the Env is fixed-length (e.g. Env.linen, Env.perc), the gate
;;        argument is used as a simple trigger. If it is an sustaining
;;        envelope (e.g. Env.adsr, Env.asr), the envelope is held open
;;        until the gate becomes 0, at which point is released.

;; levelScale - scales the levels of the breakpoints.

;; levelBias - offsets the levels of the breakpoints.

;; timeScale - scales the durations of the segments.

;; doneAction - an integer representing an action to be executed when
;;              the env is finished playing. This can be used to free
;;              the enclosing synth, etc.

;; Percussive envelope

(let* ((d (env/perc 0.01 1 1 -4))
       (e (EnvGen kr 1 0.1 0 1 removeSynth d)))
  (audition (Mul e (SinOsc ar 440 0))))

;; The break-point assistant makes a static envelope from a
;; co-ordinate list.  There is a duration and amplitude scalar.

(let* ((d (env/bp '(0 0 1/2 1 1 0) 1 1))
       (e (EnvGen kr 1 0.1 0 1 removeSynth d)))
  (audition (Mul e (SinOsc ar 440 0))))
