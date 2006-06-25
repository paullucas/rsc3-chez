;; graphdef.ss - (c) rohan drape, 2004-2006

(module
 graphdef (lib "lang.ss" "r5rs")
 (#%require (only "structure.ss"
		  define-structure)
	    (only "u8.ss"
		  u8 i16 i32 f32 pstr
		  npt->u8l)
	    (only "collection.ss"
		  foldl1)
	    (only (lib "1.ss" "srfi")
		  make-list
		  every
		  iota)
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
	    ugen-output ugen-validate ugen-transform dupn
	    make-proxy proxy? proxy-ugen proxy-port
	    make-control control-name
	    control*? control*-default control*-name
	    Mce make-mce mce? mce-channels
	    Mrg make-mrg mrg? mrg-roots
	    make-outputs
	    make-uid unique-uid
	    graphdef
	    graphdef? make-graphdef graphdef-name graphdef-defaults graphdef-controls graphdef-constant
	    graphdef-ugen graphdef-ugens graphdef->u8l
	    input make-input input-ugen input-port
	    make-output output-rate
	    ar kr ir dr
	    letc))
