;; utc.ss - (c) rohan drape, 2006

(module
 utc mzscheme
 (define (utc)
   (/ (current-inexact-milliseconds) 1000.0))
 (provide utc))
