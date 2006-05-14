;; buffer.ss - (c) rohan drape, 2004-2006

(module
 buffer mzscheme
 (require (only "collection.ss"
		mapw
		mapw*
		splice)
	  (only (lib "include.ss")
		include))
 (include "../scheme/buffer/signal.scm")
 (provide wavetable->signal
          signal->wavetable))
