;; supercollider.ss - (c) rohan drape, 2004-2006

(module
 supercollider (lib "lang.ss" "r5rs")
 (#%require (only (lib "23.ss" "srfi")
		  error)
	    (only "collection.ss"
		  splice
		  extend
		  take-cycle
		  d->dx
		  interleave
		  foldl1
		  flatten)
	    (only "math.ss"
		  round-exact
		  clip
		  pi two-pi half-pi
		  ampdb dbamp)
	    (only "u8.ss"
		  i32->u8l f32->u8l f64->u8l
		  write-u8)
	    (only "osc.ss"
		  osc->u8l
		  u8l->osc)
	    (only "structure.ss"
		  define-structure)
	    (only "graphdef.ss"
		  ir ar
		  mce? mce-channels make-mce
		  graphdef? graphdef-name graphdef->u8l
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
		  list-tabulate
		  append-map)
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
 (include "../scheme/supercollider/sndfile.scm")
 (#%provide (all-defined)))
