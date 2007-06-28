;; mce.scm - (c) rohan drape, 2005-2007

(module mce (lib "lang.ss" "r5rs")
(#%require (only "../structure/structure.scm"
		 define-structure)
	   (only (lib "23.ss" "srfi")
		 error))
(#%provide (all-defined))

(define-structure mce channels)

(define (Mce . channels)
  (if (null? channels)
      (error "empty mce")
      (make-mce channels)))

(define (mce-channel u n)
  (list-ref (mce-channels u) n))

)
