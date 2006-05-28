;; buffer.ss - (c) rohan drape, 2004-2006

(module
 buffer (lib "lang.ss" "r5rs")
 (#%require (only "collection.ss"
		  mapw
		  mapw*
		  splice)
	    (only (lib "include.ss")
		  include))
 (include "../scheme/buffer/signal.scm")
 (#%provide wavetable->signal
	    signal->wavetable))
