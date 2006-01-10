;; synthdef.scm - (c) rohan drape, 2003-2005

;; Transform a <ugen> into a <graphdef>.

(defineH synthdef graph->graphdef)

;; If ugen has output ports encapsulate it.

(defineH ugen->graphdef/out ugen
  (if (or (mce? ugen)
	  (and (ugen? ugen) (not (null? (ugen-outputs ugen)))))
      (graph->graphdef "Anonymous" (letc ((bus 0.0)) (Out bus ugen)))
      (graph->graphdef "Anonymous" ugen)))

