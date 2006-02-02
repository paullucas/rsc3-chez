;; ugen.ss - (c) rohan drape, 2004-2006

(module
 ugen mzscheme
 (require (only (lib "1.ss" "srfi") make-list filter delete-duplicates take drop iota)
	  (only (lib "26.ss" "srfi") cut)
	  (only (lib "include.ss") include)
	  "collection.ss"
	  "graphdef.ss")
 (include "../ugen/constructor.scm")
 (include "../ugen/filter.scm")
 (include "../ugen/graph.scm")
 (include "../ugen/implicit.scm")
 (include "../ugen/input.scm")
 (include "../ugen/mce.scm")
 (include "../ugen/operator.scm")
 (include "../ugen/oscillator.scm")
 (include "../ugen/proxied.scm")
 (include "../ugen/specialized.scm")
 (provide (all-defined)))
