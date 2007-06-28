;; graphdef.ss - (c) rohan drape, 2004-2007

(module
 graphdef (lib "lang.ss" "r5rs")
 (#%require "../scheme/graphdef/control.scm"
	    "../scheme/graphdef/graphdef.scm"
	    "../scheme/graphdef/id.scm"
	    "../scheme/graphdef/input.scm"
	    "../scheme/graphdef/letc.scm"
	    "../scheme/graphdef/mce.scm"
	    "../scheme/graphdef/mrg.scm"
	    "../scheme/graphdef/output.scm"
	    "../scheme/graphdef/proxy.scm"
	    "../scheme/graphdef/rate.scm"
	    "../scheme/graphdef/rate-of.scm"
	    "../scheme/graphdef/ugen.scm")
 (#%provide rate-select rate-of rate-value
	    ugen make-ugen ugen? ugen-inputs ugen-name ugen-rate ugen-outputs ugen-special ugen-id
	    ugen-output ugen-validate ugen-transform dupn
	    make-proxy proxy? proxy-ugen proxy-port
	    make-control control-name
	    control*? control*-default control*-name
	    Mce make-mce mce? mce-channels mce-channel
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
