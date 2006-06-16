;; synthdef.scm - (c) rohan drape, 2003-2006

;; Transform a <ugen> into a <graphdef>.

(define synthdef graph->graphdef)

;; If ugen has output ports encapsulate it.

(define (with-out u)
  (if (or (mce? u)
	  (and (ugen? u) (not (null? (ugen-outputs u)))))
      (letc ((bus 0.0)) (Out bus u))
      u))

(define (send-synth s n u)
  (->< s (/d_recv (graphdef->u8l (synthdef n (with-out u))))))

(define (ugen->graphdef/out u)
  (synthdef "Anonymous" (with-out u)))
