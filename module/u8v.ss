;; u8v.ss - (c) rohan drape, 2004-2006

(module
 u8v mzscheme
 (require (only "collection.ss"
		flatten)
	  (only (lib "include.ss")
		include)
	  (only (lib "1.ss" "srfi")
		fold-right))
 (include "../scheme/u8v/u8v.scm")
 (provide (all-defined)))
