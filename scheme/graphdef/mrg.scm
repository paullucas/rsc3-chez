;; mrg.scm - (c) rohan drape, 2006

(define-structure mrg roots)

(define (Mrg . roots)
  (if (null? roots)
      (error "empty mrg")
      (make-mrg roots)))
