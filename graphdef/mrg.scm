;; mrg.scm - (c) rohan drape, 2006-2007

(module mrg scheme/base

(require (only-in "../structure/structure.scm"
		  define-structure))

(provide Mrg
	 make-mrg
	 mrg?
	 mrg-roots)

(define-structure mrg roots)

(define (Mrg . roots)
  (if (null? roots)
      (error 'Mrg "empty mrg")
      (make-mrg roots)))

)
