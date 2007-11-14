;; synthdef.scm - (c) rohan drape, 2003-2007

(module synthdef scheme/base

(require (only-in "../server/command.scm"
		  /d_recv)
	 (only-in "../server/server.scm"
		  -><)
	 (only-in "../graphdef/graphdef.scm"
		  graphdef->u8l)
	 (only-in "../graphdef/letc.scm"
		  letc)
	 (only-in "../graphdef/mce.scm"
		  mce?)
	 (only-in "../graphdef/rate.scm"
		  kr)
	 (only-in "../graphdef/ugen.scm"
		  ugen?
		  ugen-outputs)
	 (only-in "../ugen/graph.scm"
		  graph->graphdef)
	 (only-in "../ugen/filter.scm"
		  Out))

(provide (all-defined-out))

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

;; A large positive integer that can be used as an argument to
;; synthdefs.

(define +inf.sc 9.0e8)

)
