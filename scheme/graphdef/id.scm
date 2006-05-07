;; id.scm - (c) rohan drape, 2005-2006

(define-structure uid value)

;; Counting from 1...

(define unique-uid
  (let ((id 0))
    (lambda ()
      (begin (set! id (+ id 1))
	     (make-uid id)))))
