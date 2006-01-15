;; rsc.ss - (c) rohan drape, 2004-2006

(module rsc mzscheme

  (define-syntax require/provide
    (syntax-rules ()
      ((_ m) (begin (require m) (provide (all-from m))))))
  
  (require (lib "rscB.ss" "rscB")
	   (lib "rscO.ss" "rscO"))
  (provide (all-from (lib "rscB.ss" "rscB"))
	   (all-from (lib "rscO.ss" "rscO")))
  
  (require/provide "scheme/module/graphdef.ss")
  (require/provide "scheme/module/server.ss")
  (require/provide "scheme/module/buffer.ss")
  (require/provide "scheme/module/ugen.ss")
  (require/provide "scheme/module/supercollider.ss")

  ;; RSC
  (require (lib "include.ss"))
  (include "scheme/rsc/rsc.scm")
  (provide (all-defined)))
