;; server.ss - (c) rohan drape, 2004-2005

(module server mzscheme
  (require (lib "rscB.ss" "rscB")
	   (lib "rscO.ss" "rscO")
	   (lib "include.ss"))
  (include "../server/command.scm")
  (include "../server/done-action.scm")
  (include "../server/server.scm")
  (provide (all-defined)))
