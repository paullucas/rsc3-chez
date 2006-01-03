;; (Linen gate attackTime susLevel releaseTime doneAction)

;; A linear envelope generator.  The done flag is set when the
;; envelope reaches zero.

;; Note that the sustain level input is consulted only at the instant
;; when the gate is opened.

(SinOsc ar 440 0 (Linen kr (MouseX kr -1 1) 1.0 (MouseY kr 0.1 0.5) 1.0 0))

;; Open gate for a random interval.

(synthdef-send
 (synthdef
  "linen"
  ((gate 0))
  (Out ar 0 (SinOsc ar 440 0 (Linen kr gate 0.1 0.2 0.1 0)))))

(-> "/s_new" "linen" 1001 1 1)

(begin (-> "/n_set" 1001 "gate" 1)
       (=>* (random) '("/n_set" 1001 "gate" 0)))

(-> "/n_free" 1001)
