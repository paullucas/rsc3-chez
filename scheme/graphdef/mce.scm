;; mce.scm - (c) rohan drape, 2005-2006

(define-structure mce channels)

(define (Mce . channels)
  (if (null? channels)
      (error "empty mce")
      (make-mce channels)))
