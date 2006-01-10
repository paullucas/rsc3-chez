;; graphdef.ss - (c) rohan drape, 2004-2005

(module graphdef mzscheme
  (require (lib "rscB.ss" "rscB")
	   (lib "rscO.ss" "rscO")
	   (lib "include.ss"))
  (include "../graphdef/control.scm")
  (include "../graphdef/graphdef.scm")
  (include "../graphdef/id.scm")
  (include "../graphdef/input.scm")
  (include "../graphdef/letc.scm")
  (include "../graphdef/mce.scm")
  (include "../graphdef/output.scm")
  (include "../graphdef/proxy.scm")
  (include "../graphdef/rate.scm")
  (include "../graphdef/ugen.scm")
  (provide (all-defined)))
