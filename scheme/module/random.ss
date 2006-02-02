;; random.ss - (c) rohan drape, 2004-2006

(module 
 random mzscheme
 (require "collection.ss"
	  "math.ss"
	  (only (lib "1.ss" "srfi") iota last)
	  (only (lib "include.ss") include))
 (include "../random/distribution.scm")
 (include "../random/range.scm")
 (include "../random/choose.scm")
 (include "../random/shuffle.scm")
 (provide (all-defined)))
