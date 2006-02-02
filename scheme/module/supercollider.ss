;; supercollider.ss - (c) rohan drape, 2004-2006

(module 
 supercollider mzscheme
 (require "collection.ss"
	  "math.ss"
	  (only (lib "1.ss" "srfi") 
		make-list)
	  ;; stream-car stream-cdr stream-null stream-null? stream-map stream->list as-stream stream-iota stream-+ stream-- stream-* stream-/ define-stream stream-cons stream-++ list->stream
	  ;; choose! shuffle! stream? plist->table
	  "u8v.ss"
	  "osc.ss"
	  "structure.ss"
	  "graphdef.ss"
	  "server.ss"
	  "ugen.ss"
	  (only (lib "include.ss") include))
 (include "../supercollider/in.scm")
 (include "../supercollider/envelope.scm")
 (include "../supercollider/gain.scm")
 (include "../supercollider/klang.scm")
 (include "../supercollider/mix.scm")
 (include "../supercollider/name.scm")
; (include "../supercollider/patterns.scm")
 (include "../supercollider/pitch.scm")
 (include "../supercollider/play.scm")
 (include "../supercollider/quantize.scm")
 (include "../supercollider/score.scm")
 (include "../supercollider/spec.scm")
 (include "../supercollider/synthdef.scm")
 (include "../supercollider/warp.scm")
 (provide (all-defined)))
