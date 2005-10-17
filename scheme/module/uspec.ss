;; uspec.ss - (c) rohan drape, 2004-2005

(module uspec mzscheme
  (require (lib "rscB.ss" "rscB")
	   (lib "rscO.ss" "rscO")
	   "graphdef.ss"
	   (lib "include.ss"))
  (include "../uspec/binaryop.scm")
  (include "../uspec/name.scm")
  (include "../uspec/unaryop.scm")
  (include "../uspec/uspec.scm")
  (include "../uspec/sc.scm")
  (provide (all-defined)))
