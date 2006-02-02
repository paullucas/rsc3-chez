;; shuffle.scm - (c) rohan drape, 2005-2006

;; Return a random permutation of the <list> `l'.  This is not a
;; mutation operation.

(define (shuffle! l)
  (map cdr
       (sort 
	(map (lambda (x) (cons (rand! 0 1) x)) l)
	(lambda (x y) (< (car x) (car y))))))
