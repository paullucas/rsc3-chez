;; synthdef.scm - (c) rohan drape, 2003-2005

(define synthdef graph->graphdef)

;; Transform a <ugen> into a <graphdef>.  If ugen has output ports
;; encapsulate it.

(define (ugen->graphdef/out ugen)
  (if (or (mce? ugen)
	  (not (null? (ugen-outputs ugen))))
      (graph->graphdef "Anonymous" (letc ((bus 0.0)) (Out bus ugen)))
      (graph->graphdef "Anonymous" ugen)))
