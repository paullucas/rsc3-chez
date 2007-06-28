;; id.scm - (c) rohan drape, 2005-2007

(module id (lib "lang.ss" "r5rs")
(#%require (only "../structure/structure.scm"
		 define-structure))
(#%provide (all-defined))

(define-structure uid value)

;; Counting from 1...

(define unique-uid
  (let ((id 0))
    (lambda ()
      (set! id (+ id 1))
      (make-uid id))))

)
