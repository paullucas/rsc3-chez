;; ugen.ss - (c) rohan drape, 2004-2007

(module
 ugen (lib "lang.ss" "r5rs")

 (define-syntax require/provide
   (syntax-rules ()
     ((_ m) (begin (#%require m) (#%provide (all-from m))))))


 (require/provide "../scheme/ugen/constructor.scm")
 (require/provide "../scheme/ugen/filter.scm")
 (require/provide "../scheme/ugen/graph.scm")
 (require/provide "../scheme/ugen/implicit.scm")
 (require/provide "../scheme/ugen/input.scm")
 (require/provide "../scheme/ugen/mce.scm")
 (require/provide "../scheme/ugen/operator.scm")
 (require/provide "../scheme/ugen/oscillator.scm")
 (require/provide "../scheme/ugen/proxied.scm")
 (require/provide "../scheme/ugen/specialized.scm"))
