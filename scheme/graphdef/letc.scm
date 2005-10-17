;; letc.scm - (c) rohan drape, 2005

;; Syntax for defining <control*> values.  Does not implement rate or
;; lag variants.  See deleted file control-set.scm for details.

(define-syntax letc
  (syntax-rules ()
    ((_ () expr) 
     expr)
    ((_ ((name default) ...) expr)
     (let ((name (make-control* (quote name) default 1 0))
	   ...)
       expr))))
