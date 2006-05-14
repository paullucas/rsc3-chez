;; supercollider.ss - (c) rohan drape, 2004-2006

(module
 supercollider mzscheme
 (require (only "collection.ss"
		splice
		extend
		take-cycle
		d->dx
		interleave
		foldl1)
	  (only "math.ss"
		round-exact
		clip
		pi two-pi half-pi
		ampdb dbamp)
	  (only "u8v.ss"
		u8v-concat u8v-++
		i32->u8v
		u8v->i32
		u8v-length
		u8v-copy*)
	  (only "osc.ss"
		osc->u8v
		u8v->osc)
	  (only "structure.ss"
		define-structure)
	  (only "graphdef.ss"
		ir ar
		mce? mce-channels make-mce
		graphdef-name graphdef->u8v
		ugen? ugen-outputs
		letc)
	  (only "server.ss"
		-> -><
		/s_new /d_recv)
	  (only "ugen.ss"
		Add Sub Mul
		In Out NumOutputBuses
		graph->graphdef)
	  (only (lib "1.ss" "srfi")
		make-list
		list-tabulate)
	  (only (lib "include.ss")
		include))
 (include "../scheme/supercollider/in.scm")
 (include "../scheme/supercollider/envelope.scm")
 (include "../scheme/supercollider/klang.scm")
 (include "../scheme/supercollider/mix.scm")
 (include "../scheme/supercollider/name.scm")
 (include "../scheme/supercollider/play.scm")
 (include "../scheme/supercollider/quantize.scm")
 (include "../scheme/supercollider/score.scm")
 (include "../scheme/supercollider/spec.scm")
 (include "../scheme/supercollider/synthdef.scm")
 (include "../scheme/supercollider/warp.scm")
 (provide (all-defined)))
