;; exact.scm - (c) rohan drape, 2004-2007

(module exact (lib "lang.ss" "r5rs")
(#%provide (all-defined))

;; Exact integer constructors and predicate.

(define (floor-exact n)    (inexact->exact (floor n)))
(define (ceiling-exact n)  (inexact->exact (ceiling n)))
(define (truncate-exact n) (inexact->exact (truncate n)))
(define (round-exact n)    (inexact->exact (round n)))
(define (exact-integer? x) (and (integer? x) (exact? x)))

)
