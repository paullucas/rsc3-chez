;; random.ss - (c) rohan drape, 2004-2007

(module
 random (lib "lang.ss" "r5rs")
 (#%require "../scheme/random/distribution.scm"
	    "../scheme/random/range.scm"
	    "../scheme/random/choose.scm"
	    "../scheme/random/shuffle.scm")
 (#%provide rand _rand rand2 randi randx randl randxl randb
	    choose choosel pchoose shuffle))
