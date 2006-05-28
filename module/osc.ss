;; osc.ss - (c) rohan drape, 2004-2006

(module
 osc (lib "lang.ss" "r5rs")
 (#%require (only "ntp.ss"
		  utc->ntp
		  ntp->utc.)
	    (only "u8v.ss"
		  u8v->string string->u8v
		  u8v-copy* u8v-index
		  u8v->i32 u8v->i64 u8v->u64 u8v->f32 u8v->f64
		  i32->u8v i64->u8v u64->u8v f32->u8v f64->u8v
		  open-input-u8v
		  u8v-++ u8v-append u8v-concat
		  make-u8v u8v? u8v-ref u8v-length
		  read-u8v)
	    (only "udp.ss"
		  udp*-send
		  udp*-recv)
	    (only (lib "1.ss" "srfi")
		  find-tail)
	    (only (lib "23.ss" "srfi")
		  error)
	    (only (lib "48.ss" "srfi")
		  format)
	    (only (lib "include.ss")
		  include))
 (include "../scheme/osc/decode.scm")
 (include "../scheme/osc/display.scm")
 (include "../scheme/osc/encode.scm")
 (include "../scheme/osc/purify.scm")
 (include "../scheme/osc/read.scm")
 (include "../scheme/osc/verify.scm")
 (include "../scheme/osc/transport.scm")
 (#%provide message
	    bundle
	    osc->u8v
	    u8v->osc
	    osc-send
	    osc-recv
	    osc-request
	    osc-display))
