;; supercollider.ss - (c) rohan drape, 2004-2006

(module
 supercollider mzscheme
 (require "collection.ss"
	  "math.ss"
	  "u8v.ss"
	  "osc.ss"
	  "structure.ss"
	  "graphdef.ss"
	  "server.ss"
	  "ugen.ss"
	  (only (lib "1.ss" "srfi")
		make-list)
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
