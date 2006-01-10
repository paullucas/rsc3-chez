;; mce.scm - (c) rohan drape, 2005-2006

(define-structure mce channels)

(defineH mce-degree m
  (length (mce-channels m)))

(defineH mce-ref m n
  (ref (mce-channels m) n))

(define (Mce . channels)
  (if (null? channels)
      (error! "empty mce")
      (make-mce channels)))
