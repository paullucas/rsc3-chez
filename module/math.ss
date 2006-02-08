;; math.ss - (c) rohan drape, 2004-2006

(module
 math mzscheme
 (require (only (lib "include.ss")
		include))
 (include "../scheme/math/clip.scm")
 (include "../scheme/math/constants.scm")
 (include "../scheme/math/exact.scm")
 (include "../scheme/math/log.scm")
 (provide (all-defined)))
