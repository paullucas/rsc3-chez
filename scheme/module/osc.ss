;; osc.ss - (c) rohan drape, 2004-2006

(module
 osc mzscheme
 (require "ntp.ss"
	  "u8v.ss"
	  "udp.ss"
	  (only (lib "1.ss" "srfi") find-tail)
	  (only (lib "include.ss") include))
 (include "../osc/decode.scm")
 (include "../osc/display.scm")
 (include "../osc/encode.scm")
 (include "../osc/purify.scm")
 (include "../osc/read.scm")
 (include "../osc/verify.scm")
 (include "../osc/write.scm")
 (include "../osc/transport.scm")
 (provide osc->u8v u8v->osc osc-send! osc-recv! osc-request! osc-display!))
