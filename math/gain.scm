;; gain.scm - (c) rohan drape, 2000-2007

(module gain scheme/base

(require (only-in "log.scm" log10))

(provide ampdb dbamp)

;; Convert a linear rms gain value to a decibel value and the inverse.
;; Zero decibels is unity gain.  These algorithms are from SC3.

(define (ampdb amp) (* (log10 amp) 20))
(define (dbamp db)  (expt 10 (* db 0.05)))

(define (powdb pow) (* (log10 pow) 10))
(define (dbpow db)  (expt 10 (* db 0.1)))

)
