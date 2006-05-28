;; math.ss - (c) rohan drape, 2004-2006

(module
 math (lib "lang.ss" "r5rs")
 (#%require (only (lib "include.ss")
		  include)
	    (only "collection.ss"
		  ref/wrap))
 (include "../scheme/math/clip.scm")
 (include "../scheme/math/common.scm")
 (include "../scheme/math/constants.scm")
 (include "../scheme/math/exact.scm")
 (include "../scheme/math/gain.scm")
 (include "../scheme/math/log.scm")
 (include "../scheme/math/pitch.scm")
 (#%provide clip
	    pi half-pi two-pi
	    floor-exact round-exact
	    log2 log10
	    midicps cpsmidi
	    octcps cpsoct
	    ampdb dbamp
	    midiratio ratiomidi
	    squared cubed
	    recip))
