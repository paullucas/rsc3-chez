;; ntp.ss - (c) rohan drape, 2004-2006

(module
 ntp (lib "lang.ss" "r5rs")
 (#%require (only "math.ss"
		  round-exact)
	    (only (lib "19.ss" "srfi")
		  make-time
		  time-second
		  time-nanosecond
		  time-utc)
	    (only "bits.ss"
		  bitwise-ior
		  bitwise-and
		  arithmetic-shift)
	    (only (lib "include.ss")
		  include))
 (include "../scheme/ntp/ntp.scm")
 (#%provide ntp->utc.
	    utc->ntp))
