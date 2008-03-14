;; Extend all lists at `l' to be equal in length to the longest list
;; at `l'.  If any element is not a list it is replaced with a list of
;; itself of that length.

(define extend-all
  (lambda (l)
    (let* ((f (lambda (x) (if (list? x) (length x) 1)))
	   (n (maximum (map1 f l))))
      (map1 (lambda (e) (extend e n)) l))))

