;; rsc.ss - (c) rohan drape, 2004-2006

(module 
 rsc mzscheme

 (define-syntax require/provide
   (syntax-rules ()
     ((_ m) (begin (require m) (provide (all-from m))))))
 
 (require/provide "module/collection.ss")
 (require/provide "module/structure.ss")
 (require/provide "module/random.ss")
 (require/provide "module/math.ss")
 (require/provide "module/hash.ss")
 (require/provide "module/ntp.ss")
 (require/provide "module/u8v.ss")
 (require/provide "module/udp.ss")
 (require/provide "module/graphdef.ss")
 (require/provide "module/server.ss")
 (require/provide "module/buffer.ss")
 (require/provide "module/ugen.ss")
 (require/provide "module/supercollider.ss")
 
 ;; RSC
 (require (only (lib "include.ss") include))
 (include "scheme/rsc/rsc.scm")
 (provide (all-defined)))
