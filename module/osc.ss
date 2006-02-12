;; osc.ss - (c) rohan drape, 2004-2006

(module
 osc mzscheme
 (require "ntp.ss"
	  "u8v.ss"
	  "udp.ss"
	  (only (lib "1.ss" "srfi")
		find-tail)
	  (only (lib "include.ss")
		include))
 (include "../scheme/osc/decode.scm")
 (include "../scheme/osc/display.scm")
 (include "../scheme/osc/encode.scm")
 (include "../scheme/osc/purify.scm")
 (include "../scheme/osc/read.scm")
 (include "../scheme/osc/verify.scm")
 (include "../scheme/osc/write.scm")
 (include "../scheme/osc/transport.scm")
 (provide osc->u8v u8v->osc osc-send osc-recv osc-request osc-display))
