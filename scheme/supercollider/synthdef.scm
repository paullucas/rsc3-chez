;; synthdef.scm - (c) rohan drape, 2003-2007

(module synthdef (lib "lang.ss" "r5rs")
(#%require (only "../server/command.scm"
		 /d_recv)
	   (only "../server/server.scm"
		 -><)
	   (only "../graphdef/graphdef.scm"
		 graphdef->u8l)
	   (only "../graphdef/letc.scm"
		 letc)
	   (only "../graphdef/mce.scm"
		 mce?)
	   (only "../graphdef/rate.scm"
		 kr)
	   (only "../graphdef/ugen.scm"
		 ugen?
		 ugen-outputs)
	   (only "../ugen/graph.scm"
		 graph->graphdef)
	   (only "../ugen/filter.scm"
		 Out))
(#%provide (all-defined))

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
