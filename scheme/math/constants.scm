;; constants.scm - (c) rohan drape, 2001-2007

(module constants (lib "lang.ss" "r5rs")
(#%provide (all-defined))

(define e (exp 1.0))
(define pi (* 4 (atan 1)))
(define two-pi (* 2 pi))
(define half-pi (/ pi 2))

;; SuperCollider names.

(define pi2    half-pi)
(define pi32   (* pi 1.5))
(define twopi  two-pi)
(define rtwopi (/ 1.0 two-pi))
(define log001 (log 0.001))
(define log01  (log 0.01))
(define log1   (log 0.1))
(define rlog2  (/ 1.0 (log 2.0)))
(define sqrt2  (sqrt 2.0))
(define rsqrt2 (/ 1.0 sqrt2))

;; +inf.0 does not write to UGen graph files...

(define inf 1073741824.0)

)
