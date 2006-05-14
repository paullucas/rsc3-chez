;; random.ss - (c) rohan drape, 2004-2006

(module
 random mzscheme
 (require (only "collection.ss"
		dx->d
		foldl1
		sort)
	  (only "math.ss"
		clip
		pi
		floor-exact)
	  (only (lib "1.ss" "srfi")
		iota
		last
		list-index)
	  (only (lib "include.ss")
		include))
 (include "../scheme/random/distribution.scm")
 (include "../scheme/random/range.scm")
 (include "../scheme/random/choose.scm")
 (include "../scheme/random/shuffle.scm")
 (provide (all-defined)))
