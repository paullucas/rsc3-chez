;; mce.scm - (c) rohan drape, 2005

(define-structure mce values)

(defineH mce-length m
  (length (mce-values m)))

(defineH mce-ref m n
  (ref (mce-values m) n))

(define (Mce . l) 
  (if (null? l)
      (error! "empty mce")
      (make-mce l)))
