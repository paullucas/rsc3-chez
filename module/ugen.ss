;; ugen.ss - (c) rohan drape, 2004-2006

(module
 ugen mzscheme
 (require (only "collection.ss"
		splice
		concat
		extend
		maximum
		invert)
	  (only "graphdef.ss"
		rate-select
		rate-of
		make-ugen ugen? ugen-inputs ugen-name ugen-rate ugen-outputs ugen-special ugen-id
		ugen-validate
		make-proxy proxy? proxy-ugen proxy-port
		make-control
		control*? control*-default control*-name
		make-mce mce? mce-channels
		make-mrg mrg? mrg-roots
		make-outputs
		make-uid unique-uid
		make-graphdef
		make-input
		make-output
		ar kr dr)
	  (only "random.ss"
		rand
		_rand
		rand2)
	  (only "math.ss"
		midicps
		cpsmidi
		octcps
		cpsoct
		ampdb
		dbamp
		midiratio
		ratiomidi
		log2
		log10
		squared
		cubed
		recip)
	  (only (lib "1.ss" "srfi")
		make-list
		filter
		delete-duplicates
		take
		drop
		iota
		list-index)
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
