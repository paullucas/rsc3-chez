;; letc.scm - (c) rohan drape, 2005-2007

(module letc (lib "lang.ss" "r5rs")
(#%require (only "../structure/structure.scm"
		 define-structure)
	   "control.scm"
	   (only "rate.scm"
		 kr))
(#%provide (all-defined))

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
