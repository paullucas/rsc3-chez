;; rsc.ss - (c) rohan drape, 2004-2006

(module
 rsc (lib "lang.ss" "r5rs")
 (#%require (only (lib "include.ss")
		include))
 (include "../scheme/rsc/rsc.scm")
 (#%provide rsc-directory
	    rsc-file))
