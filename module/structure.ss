;; structure.ss - (c) rohan drape, 2003-2006

(module
 structure mzscheme
 (define-syntax define-structure
   (syntax-rules ()
     ((_ name field ...)
      (define-struct name (field ...) (make-inspector)))))
 (provide define-structure))
