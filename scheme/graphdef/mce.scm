;; mce.scm - (c) rohan drape, 2005

(define-structure mce values)

(define (make-mce* . l) 
  (if (null? l)
      (error! "empty mce")
      (make-mce l)))

(define Mce make-mce*)

(define (mce-length m) 
  (length (mce-values m)))

(define (mce-ref m n)
  (ref (mce-values m) n))
