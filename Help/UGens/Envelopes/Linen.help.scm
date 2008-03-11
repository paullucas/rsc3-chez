;; (Linen gate attackTime susLevel releaseTime doneAction)

;; A linear envelope generator.  The done flag is set when the
;; envelope reaches zero.

;; Note that the sustain level input is consulted only at the instant
;; when the gate is opened.

(audition 
 (Mul* (Linen (Impulse kr 2 0) 0.01 0.6 0.4 doNothing)
       (SinOsc ar 440 0)
       0.1))

(let ((y (MouseY kr 0.1 0.5 0 0.1))
      (x (MouseX kr -1 1 0 0.1))
      (o (SinOsc ar 440 0)))
  (audition (Mul o (Linen x 1 y 1.0 doNothing))))

;; Open gate for a random interval.

(let* ((r (rand 0.05 0.4))
       (u (letc ((gate 0))
	    (let ((e (Linen gate 0.1 0.2 0.1 doNothing)))
	      (Out 0 (Mul (SinOsc ar 440 0) e)))))
       (g (graphdef->u8l (synthdef "linen" u))))
  (with-sc3
   (lambda (fd)
     (async fd (/d_recv g))
     (send fd (/s_new "linen" 1001 1 1))
     (send fd (bundle (utc) (/n_set 1001 "gate" 1)))
     (send fd (bundle (+ (utc) r)
		    (/n_set 1001 "gate" 0)))
     (sleep (* r 4))
     (send fd (/n_free 1001)))))
