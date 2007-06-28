;; structure.scm - (c) rohan drape, 2000-2007

(module structure mzscheme
(provide (all-defined))

(define-syntax define-structure
   (syntax-rules ()
     ((_ name field ...)
      (define-struct name (field ...) (make-inspector)))))

)
