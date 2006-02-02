;; tree.scm - (c) rohan drape, 2000-2006

;; A not entirely naive flatten - ie. does not use append.

(define (flatten* t r)
  (cond ((null? t) r)
	((list? t) (flatten* (car t) (flatten* (cdr t) r)))
	(else      (cons t r))))

(define (flatten t) (flatten* t '()))
