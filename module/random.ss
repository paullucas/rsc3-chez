;; random.ss - (c) rohan drape, 2004-2006

(module
 random (lib "lang.ss" "r5rs")
 (#%require (only "collection.ss"
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
	    (only (lib "27.ss" "srfi")
		  random-real)
	    (only (lib "39.ss" "srfi")
		  make-parameter)
	    (only (lib "include.ss")
		  include))
 (include "../scheme/random/distribution.scm")
 (include "../scheme/random/range.scm")
 (include "../scheme/random/choose.scm")
 (include "../scheme/random/shuffle.scm")
 (#%provide rand _rand rand2 randi randx randl randb
	    choose pchoose shuffle))
