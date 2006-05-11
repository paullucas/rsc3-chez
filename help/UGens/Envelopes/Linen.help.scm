;; (Linen gate attackTime susLevel releaseTime doneAction)

;; A linear envelope generator.  The done flag is set when the
;; envelope reaches zero.

;; Note that the sustain level input is consulted only at the instant
;; when the gate is opened.

(Mul (SinOsc ar 440 0)
     (Linen (MouseX kr -1 1 0 0.1) 1 (MouseY kr 0.1 0.5 0 0.1) 1.0 0))

;; Open gate for a random interval.

(define g
  (graphdef->u8v
   (synthdef
    "linen"
    (letc ((gate 0))
      (Out 0 (Mul (SinOsc ar 440 0) (Linen gate 0.1 0.2 0.1 0)))))))

(->< s (/d_recv g))

(-> s (/s_new "linen" 1001 1 1))

(begin (-> s (bundle (utc) (/n_set 1001 "gate" 1)))
       (-> s (bundle (+ (utc) (rand 0.05 0.4))
		     (/n_set 1001 "gate" 0))))

(-> s (/n_free 1001))
