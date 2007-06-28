;; mrg.scm - (c) rohan drape, 2006-2007

(module mrg (lib "lang.ss" "r5rs")
(#%require (only "../structure/structure.scm"
		 define-structure)
	   (only (lib "23.ss" "srfi")
		 error))
(#%provide (all-defined))

(define-structure mrg roots)

(define (Mrg . roots)
  (if (null? roots)
      (error "empty mrg")
      (make-mrg roots)))

)
