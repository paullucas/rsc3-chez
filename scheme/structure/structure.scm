;; structure.scm - (c) rohan drape, 2000-2006

(define-syntax define-structure
   (syntax-rules ()
     ((_ name field ...)
      (define-struct name (field ...) (make-inspector)))))
