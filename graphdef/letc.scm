;; letc.scm - (c) rohan drape, 2005-2007

(module letc scheme/base

(require (only-in "../structure/structure.scm"
		  define-structure)
	 (only-in "control.scm"
		  make-control*)
	 (only-in "rate.scm"
		  kr))
(provide letc)

;; Syntax for defining <control*> values.  Does not implement rate or
;; lag variants.  See deleted file control-set.scm for details.

(define-syntax letc
  (syntax-rules ()
    ((_ () expr)
     expr)
    ((_ ((name default) ...) expr)
     (let ((name (make-control* (symbol->string (quote name)) default kr 0))
	   ...)
       expr))))

)
