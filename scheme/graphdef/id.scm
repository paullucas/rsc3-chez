;; id.scm - (c) rohan drape, 2005

(define-structure uid value)

(defineH uid=? a b
  (= (uid-value a) (uid-value b)))

(defineH r0 (make-uid 0))
(defineH r1 (make-uid 1))
