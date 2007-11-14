;; id.scm - (c) rohan drape, 2005-2007

(module id scheme/base

(require (only-in "../structure/structure.scm"
		  define-structure))

(provide make-uid
	 uid?
	 unique-uid)

(define-structure uid value)

;; Counting from 1...

(define unique-uid
  (let ((id 0))
    (lambda ()
      (set! id (+ id 1))
      (make-uid id))))

)
