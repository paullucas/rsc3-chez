;; ugen.ss - (c) rohan drape, 2004-2005

(module ugen mzscheme
  (require (lib "rscB.ss" "rscB")
	   (lib "rscO.ss" "rscO")
	   "graphdef.ss"
	   (lib "include.ss"))
  (include "../ugen/constructor.scm")
  (include "../ugen/filter.scm")
  (include "../ugen/graph.scm")
  (include "../ugen/implicit.scm")
  (include "../ugen/input.scm")
  (include "../ugen/mce.scm")
  (include "../ugen/operator.scm")
  (include "../ugen/oscillator.scm")
  (include "../ugen/proxied.scm")
  (include "../ugen/specialized.scm")
  (provide (all-defined)))
