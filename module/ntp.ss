;; ntp.ss - (c) rohan drape, 2004-2007

(module
 ntp (lib "lang.ss" "r5rs")
 (#%require "../scheme/ntp/ntp.scm")
 (#%provide ntp->utc.
	    utc->ntp))
