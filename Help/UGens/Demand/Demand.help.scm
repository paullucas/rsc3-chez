;; (Demand trig reset ugens)

;; Demand results from demand rate ugens.

;; When there is a trigger at the trig input, a value is demanded from
;; each ugen in the list and output. The unit generators in the list
;; should be 'demand' rate.

;; When there is a trigger at the reset input, the demand rate ugens
;; in the list are reset.

;; trig - trigger. Trigger can be any signal. A trigger happens when
;;                 the signal changes from non-positive to positive.

;; reset - trigger. Resets the list of ugens when triggered.

(require srfi/1)

(define (mirror1 l) 
  (append l (cdr (reverse (cdr l)))))

(let* ((t (Impulse kr 24 0))
       (s (Drand +inf.sc (Mce (Dseq 1 (make-mce (mirror1 (iota 5 1))))
			      (Drand 8 (make-mce (iota 7 4))))))
       (f (Demand t 0 (Mul s 100)))
       (x (MouseX kr -1 1 0 0.1))
       (o (SinOsc ar (Mce f (Add f 0.7)) 0)))
  (audition (Mul (ScaleNeg (Cubed (Cubed o)) x) 0.1)))

(let* ((t (Impulse kr 10 0))
       (r (Dust kr 1))
       (s (Dgeom +inf.sc (midicps 72) (midiratio 1)))
       (f (Demand t r s))
       (o (SinOsc ar (Mce f (Add f 0.7)) 0)))
  (audition (Mul (Max (Cubed o) 0) 0.1)))

(let* ((t (Impulse kr 10 0))
       (s (MIDICPS (Diwhite +inf.sc 60 72)))
       (f (Demand t 0 s))
       (o (SinOsc ar (Mce f (Add f 0.7)) 0)))
  (audition (Mul (Cubed (Cubed o)) 0.1)))
