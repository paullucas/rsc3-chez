;; osc.ss - (c) rohan drape, 2004-2006

(module
 osc (lib "lang.ss" "r5rs")
 (#%require (only "ntp.ss"
		  utc->ntp
		  ntp->utc.)
	    (only "u8v.ss"
		  u8 i32 i64 u64 f32 f64
		  _i32 _i64 _u64 _f32 _f64
		  str u8v*
		  mk-u8v
		  u8v->string
		  u8v-copy*
		  u8v-index
		  u8v-ref
		  u8v-concat
		  read-u8v
		  open-input-u8v
		  u8v-length
		  u8v?)
	    (only "udp.ss"
		  udp*-send
		  udp*-recv)
	    (only (lib "1.ss" "srfi")
		  find-tail
		  make-list)
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
