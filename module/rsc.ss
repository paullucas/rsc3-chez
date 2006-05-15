;; rsc.ss - (c) rohan drape, 2004-2006

(module
 rsc mzscheme
 (require (only (lib "include.ss")
		include))
 (include "../scheme/rsc/rsc.scm")
 (provide rsc-directory
	  rsc-file))
