;; ugen.ss - (c) rohan drape, 2004-2006

(module
 ugen mzscheme
 (require "collection.ss"
	  "graphdef.ss"
	  (only (lib "1.ss" "srfi")
		make-list
		filter
		delete-duplicates
		take
		drop
		iota)
	  (only (lib "26.ss" "srfi")
		cut)
	  (only (lib "include.ss")
		include))
 (include "../scheme/ugen/constructor.scm")
 (include "../scheme/ugen/filter.scm")
 (include "../scheme/ugen/graph.scm")
 (include "../scheme/ugen/implicit.scm")
 (include "../scheme/ugen/input.scm")
 (include "../scheme/ugen/mce.scm")
 (include "../scheme/ugen/operator.scm")
 (include "../scheme/ugen/oscillator.scm")
 (include "../scheme/ugen/proxied.scm")
 (include "../scheme/ugen/specialized.scm")
 (provide (all-defined)))
