;; write.scm - (c) rohan drape, 2002-2006

;; Write variants of encode procedures.

(define-syntax defineW
  (syntax-rules ()
    ((_ w e) (define (w v p) (write-u8v (e v) p)))))

#|
(defineW write-string          encode-string)
(defineW write-bytes           encode-bytes)
(defineW write-value           encode-value)
(defineW write-types           encode-types)
(defineW write-message         encode-message)
(defineW write-bundle          encode-bundle)
(defineW write-packet          encode-packet)
|#
