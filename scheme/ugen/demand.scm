;; demand.scm - (c) rohan drape, 2005

(define-specialized Dgeom (length start grow) 1 dr)
(define-specialized Dseries (length start step) 1 dr)

(define-specialized! Dbrown (length lo hi step) 1 dr)
(define-specialized! Dibrown (length lo hi step) 1 dr)
(define-specialized! Diwhite (length lo hi) 1 dr)
(define-specialized! Dwhite (length lo hi) 1 dr)

(define-specialized* Dseq (length array) 1 dr)
(define-specialized* Dser (length array) 1 dr)
(define-specialized* Dswitch1 (length array) 1 dr)

(define-specialized*! Drand (length array) 1 dr)
(define-specialized*! Dxrand (length array) 1 dr)
