;; server.ss - (c) rohan drape, 2004-2006

(module
 server (lib "lang.ss" "r5rs")
 (#%require (only (lib "23.ss" "srfi")
		  error)
	    (only (lib "39.ss" "srfi")
		  make-parameter parameterize)
	    (only "osc.ss"
		  osc-send
		  osc-recv
		  message
		  bundle)
	    (only "utc.ss"
		  utc)
	    (only "collection.ss"
		  splice intersperse)
	    (only (lib "include.ss")
		  include))
 (include "../scheme/server/command.scm")
 (include "../scheme/server/add-action.scm")
 (include "../scheme/server/done-action.scm")
 (include "../scheme/server/gen.scm")
 (include "../scheme/server/server.scm")
 (include "../scheme/server/status.scm")
 (#%provide (all-defined)))
