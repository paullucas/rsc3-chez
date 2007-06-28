;; osc.ss - (c) rohan drape, 2004-2007

(module
 osc (lib "lang.ss" "r5rs")
 (#%require "../scheme/osc/type.scm"
	    "../scheme/osc/decode.scm"
	    "../scheme/osc/display.scm"
	    "../scheme/osc/encode.scm"
	    "../scheme/osc/purify.scm"
	    "../scheme/osc/verify.scm"
	    "../scheme/osc/transport.scm")
 (#%provide message
	    bundle
	    osc->u8l
	    u8l->osc
	    osc-send
	    osc-recv
	    osc-request
	    osc-display))
