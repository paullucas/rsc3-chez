;; mce.scm - (c) rohan drape, 2005-2006

(define-structure mce channels)

(define (Mce . channels)
  (if (null? channels)
      (error "empty mce")
      (make-mce channels)))

(define (mce-channel u n)
  (list-ref (mce-channels u) n))
