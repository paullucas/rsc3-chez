;; log.scm - (c) rohan drape, 2001-2007

(module log (lib "lang.ss" "r5rs")
(#%provide log2 log10)

(define (log* n)         (if (zero? n) n (log n))) 
(define (log2 x)         (/ (log (abs x)) (log 2)))
(define (log10 x)        (/ (log x) (log 10)))

)
