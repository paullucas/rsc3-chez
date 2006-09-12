;; osc.ss - (c) rohan drape, 2004-2006

(module
 osc (lib "lang.ss" "r5rs")
 (#%require (only "ntp.ss"
		  utc->ntp
		  ntp->utc.)
	    (only "u8.ss"
		  u8 i32 i64 u64 f32 f64
		  read-i32 read-i64 read-u64 read-f32 read-f64
		  cstr bstr
		  read-cstr read-bstr
		  peek-u8 read-u8l
		  npt->u8l
		  u8l?
		  with-input-from-u8l)
	    (only "udp.ss"
		  udp*-send
		  udp*-recv)
	    (only (lib "1.ss" "srfi")
		  find-tail
		  make-list
		  iota
		  )
	    (only (lib "23.ss" "srfi")
		  error)
	    (only (lib "48.ss" "srfi")
		  format)
	    (only (lib "include.ss")
		  include))
 (include "../scheme/osc/type.scm")
 (include "../scheme/osc/decode.scm")
 (include "../scheme/osc/display.scm")
 (include "../scheme/osc/encode.scm")
 (include "../scheme/osc/purify.scm")
 (include "../scheme/osc/verify.scm")
 (include "../scheme/osc/transport.scm")
 (#%provide message
	    bundle
	    osc->u8l
	    u8l->osc
	    osc-send
	    osc-recv
	    osc-request
	    osc-display))
