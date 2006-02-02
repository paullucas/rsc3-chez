;; synthdef.scm - (c) rohan drape, 2003-2006

;; Transform a <ugen> into a <graphdef>.

(define synthdef graph->graphdef)

;; If ugen has output ports encapsulate it.

(define (ugen->graphdef/out ugen)
  (if (or (mce? ugen)
	  (and (ugen? ugen) (not (null? (ugen-outputs ugen)))))
      (graph->graphdef "Anonymous" (letc ((bus 0.0)) (Out bus ugen)))
      (graph->graphdef "Anonymous" ugen)))
