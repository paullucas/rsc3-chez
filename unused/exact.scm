;; float -> int
(define ceiling-exact
  (compose inexact->exact ceiling))

;; float -> int
(define truncate-exact
  (compose inexact->exact truncate))

