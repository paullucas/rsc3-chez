;; ntp.ss - (c) rohan drape, 2004-2006

(module 
 ntp mzscheme
 (require "math.ss"
	  (only (lib "19.ss" "srfi") time-second time-nanosecond make-time time-utc)
	  (only (lib "include.ss") include))
 (include "../ntp/ntp.scm")
 (provide (all-defined)))
