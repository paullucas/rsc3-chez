;; supercollider.ss - (c) rohan drape, 2004-2007

(module
 supercollider (lib "lang.ss" "r5rs")

 (define-syntax require/provide
   (syntax-rules ()
     ((_ m) (begin (#%require m) (#%provide (all-from m))))))

 (require/provide "../scheme/supercollider/in.scm")
 (require/provide "../scheme/supercollider/envelope.scm")
 (require/provide "../scheme/supercollider/klang.scm")
 (require/provide "../scheme/supercollider/mix.scm")
 (require/provide "../scheme/supercollider/name.scm")
 (require/provide "../scheme/supercollider/play.scm")
 (require/provide "../scheme/supercollider/quantize.scm")
 (require/provide "../scheme/supercollider/range.scm")
 (require/provide "../scheme/supercollider/score.scm")
 (require/provide "../scheme/supercollider/spec.scm")
 (require/provide "../scheme/supercollider/synthdef.scm")
 (require/provide "../scheme/supercollider/warp.scm")
 (require/provide "../scheme/supercollider/sndfile.scm"))
