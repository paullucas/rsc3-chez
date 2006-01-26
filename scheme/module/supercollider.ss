;; supercollider.ss - (c) rohan drape, 2004-2006

(module supercollider mzscheme
  (require (lib "rscB.ss" "rscB")
	   (lib "rscO.ss" "rscO")
	   "graphdef.ss"
	   "server.ss"
	   "ugen.ss"
	   (lib "include.ss"))
  (include "../supercollider/in.scm")
  (include "../supercollider/envelope.scm")
  (include "../supercollider/gain.scm")
  (include "../supercollider/klang.scm")
  (include "../supercollider/mix.scm")
  (include "../supercollider/name.scm")
  (include "../supercollider/patterns.scm")
  (include "../supercollider/pitch.scm")
  (include "../supercollider/play.scm")
  (include "../supercollider/score.scm")
  (include "../supercollider/spec.scm")
  (include "../supercollider/synthdef.scm")
  (include "../supercollider/warp.scm")
  (provide (all-defined)))
