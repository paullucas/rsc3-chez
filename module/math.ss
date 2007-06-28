;; math.ss - (c) rohan drape, 2004-2007

(module
 math (lib "lang.ss" "r5rs")
 (#%require "../scheme/math/clip.scm"
	    "../scheme/math/common.scm"
	    "../scheme/math/constants.scm"
	    "../scheme/math/exact.scm"
	    "../scheme/math/gain.scm"
	    "../scheme/math/log.scm"
	    "../scheme/math/pitch.scm")
 (#%provide clip
	    pi half-pi two-pi
	    floor-exact round-exact
	    log2 log10
	    midicps cpsmidi
	    octcps cpsoct
	    ampdb dbamp
	    midiratio ratiomidi
	    degree->key
	    squared cubed
	    recip))
