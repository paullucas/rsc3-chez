;; structure.ss - (c) rohan drape, 2003-2006

(module
 structure mzscheme
 (require (only (lib "include.ss")
		include))
 (include "../scheme/structure/structure.scm")
 (provide define-structure))
