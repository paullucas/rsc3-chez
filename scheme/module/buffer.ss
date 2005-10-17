;; buffer.ss - (c) rohan drape, 2004-2005

(module buffer mzscheme
  (require (lib "rscB.ss" "rscB")
	   (lib "rscO.ss" "rscO")
	   "server.ss"
	   (lib "include.ss"))
  (include "../buffer/signal.scm")
  (provide (all-defined)))
