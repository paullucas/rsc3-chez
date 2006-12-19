;; tree.scm - (c) rohan drape, 2000-2006

;; A not entirely naive flatten - ie. does not use append.

(define (flatten* t r)
  (cond ((null? t) r)
	((list? t) (flatten* (car t) (flatten* (cdr t) r)))
	(else      (cons t r))))

(define (flatten t) 
  (flatten* t '()))

;; Map f over the leaf nodes of t.

(define (mapt f t)
  (cond ((null? t) (list))
	((list? t) (map (lambda (e) (mapt f e)) t))
	(else      (f t))))
