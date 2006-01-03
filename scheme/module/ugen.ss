;; ugen.ss - (c) rohan drape, 2004-2005

(module ugen mzscheme
  (require (lib "rscB.ss" "rscB")
	   (lib "rscO.ss" "rscO")
	   "graphdef.ss"
	   "uspec.ss"
	   (lib "include.ss"))
  (include "../ugen/constructor.scm")
  (include "../ugen/graph.scm")
  (include "../ugen/implicit.scm")
  (include "../ugen/mce.scm")
  (include "../ugen/mul-add.scm")
  (include "../ugen/proxied.scm")

  (include "../ugen/procedures.scm")
  (include "../ugen/operator.scm")

  (provide (all-defined)))
