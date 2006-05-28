;; graphdef.ss - (c) rohan drape, 2004-2006

(module
 graphdef (lib "lang.ss" "r5rs")
 (#%require (only "structure.ss"
		  define-structure)
	    (only "u8v.ss"
		  string->u8v pstring->u8v
		  i8->u8v i16->u8v i32->u8v f32->u8v
		  u8t->u8v)
	    (only "collection.ss"
		  foldl1)
	    (only (lib "1.ss" "srfi")
		  make-list
		  every)
	    (only (lib "23.ss" "srfi")
		  error)
	    (only (lib "include.ss")
		  include))
 (include "../scheme/graphdef/control.scm")
 (include "../scheme/graphdef/graphdef.scm")
 (include "../scheme/graphdef/id.scm")
 (include "../scheme/graphdef/input.scm")
 (include "../scheme/graphdef/letc.scm")
 (include "../scheme/graphdef/mce.scm")
 (include "../scheme/graphdef/mrg.scm")
 (include "../scheme/graphdef/output.scm")
 (include "../scheme/graphdef/proxy.scm")
 (include "../scheme/graphdef/rate.scm")
 (include "../scheme/graphdef/ugen.scm")
 (#%provide rate-select rate-of rate-value
	    ugen make-ugen ugen? ugen-inputs ugen-name ugen-rate ugen-outputs ugen-special ugen-id
	    ugen-output ugen-validate
	    make-proxy proxy? proxy-ugen proxy-port
	    make-control control-name
	    control*? control*-default control*-name
	    make-mce mce? mce-channels
	    make-mrg mrg? mrg-roots
	    make-outputs
	    make-uid unique-uid
	    graphdef make-graphdef graphdef-name graphdef-defaults graphdef-controls graphdef-constant
	    graphdef-ugen graphdef-ugens graphdef->u8v
	    input make-input input-ugen input-port
	    make-output output-rate
	    ar kr ir dr
	    letc))
