;; structure.scm - (c) rohan drape, 2000-2007

(module structure scheme/base

(provide define-structure)

(define-syntax define-structure
   (syntax-rules ()
     ((_ name field ...)
      (define-struct name (field ...) #:mutable #:inspector (make-inspector)))))

)
