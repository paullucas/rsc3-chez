;; id.scm - (c) rohan drape, 2005-2006

(define-structure uid value)

(define (uid=? a b)
  (= (uid-value a) (uid-value b)))

(define R0 (make-uid 0))
(define R1 (make-uid 1))
