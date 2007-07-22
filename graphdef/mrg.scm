;; mrg.scm - (c) rohan drape, 2006-2007

(module mrg (lib "lang.ss" "r5rs")
(#%require "../mzscheme/r6rs.ss"
	   (only "../structure/structure.scm"
		 define-structure))
(#%provide Mrg 
	   make-mrg 
	   mrg? 
	   mrg-roots)

(define-structure mrg roots)

(define (Mrg . roots)
  (if (null? roots)
      (error 'Mrg "empty mrg")
      (make-mrg roots)))

)
