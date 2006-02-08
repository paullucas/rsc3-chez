;; ntp.ss - (c) rohan drape, 2004-2006

(module
 ntp mzscheme
 (require "math.ss"
	  (only (lib "19.ss" "srfi")
		make-time
		time-second
		time-nanosecond
		time-utc)
	  (only (lib "include.ss")
		include))
 (include "../scheme/ntp/ntp.scm")
 (provide (all-defined)))
