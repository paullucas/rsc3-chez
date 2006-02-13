;; id.scm - (c) rohan drape, 2005-2006

(define-structure uid value)

;; This is not pretty... Make R0 not equal to any other uid.

(define transform-uid
  (let ((id 0))
    (lambda (u)
      (if (= (uid-value u) 0)
	  (begin (set! id (- id 1))
		 (make-uid id))
	  u))))

(define R0 (make-uid 0))
(define R1 (make-uid 1))
(define R2 (make-uid 2))
(define R3 (make-uid 3))
(define R4 (make-uid 4))
(define R5 (make-uid 5))
