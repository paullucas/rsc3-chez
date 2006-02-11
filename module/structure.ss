;; structure.ss - (c) rohan drape, 2003-2006

(module
 structure mzscheme
 (require (only (lib "include.ss")
		include)
	  (only (lib "plt-match.ss")
		match-let))
 (require-for-syntax (only (lib "stx.ss" "syntax")
			   module-or-top-identifier=?))
 (include "../scheme/structure/structure.scm")
 (include "../scheme/structure/define.scm")
 (provide define-structure define*))
