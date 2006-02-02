;; rsc.ss - (c) rohan drape, 2004-2006

(module 
 rsc mzscheme

 (define-syntax require/provide
   (syntax-rules ()
     ((_ m) (begin (require m) (provide (all-from m))))))
 
 (require/provide "scheme/module/collection.ss")
 (require/provide "scheme/module/random.ss")
 (require/provide "scheme/module/math.ss")
 (require/provide "scheme/module/hash.ss")
 (require/provide "scheme/module/ntp.ss")
 (require/provide "scheme/module/u8v.ss")
 (require/provide "scheme/module/udp.ss")
 (require/provide "scheme/module/graphdef.ss")
 (require/provide "scheme/module/server.ss")
 (require/provide "scheme/module/buffer.ss")
 (require/provide "scheme/module/ugen.ss")
 (require/provide "scheme/module/supercollider.ss")
 
 ;; RSC
 (require (only (lib "include.ss") include))
 (include "scheme/rsc/rsc.scm")
 (provide (all-defined)))
