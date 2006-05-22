;; server.ss - (c) rohan drape, 2004-2006

(module
 server mzscheme
 (require (only "osc.ss"
		osc-send
		osc-recv
		message)
	  (only "collection.ss"
		splice)
	  (only (lib "include.ss")
		include))
 (include "../scheme/server/command.scm")
 (include "../scheme/server/done-action.scm")
 (include "../scheme/server/server.scm")
 (provide (all-defined)))
