;; Tree a -> Tree a
(define splice 
  (lambda (l)
    (let ((f (lambda (a b)
	       (if (list? a)
		   (append2 a b)
		   (cons a b)))))
      (foldr f nil l))))
