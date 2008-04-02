;; double -> bool
(define thread-sleep
  (lambda (p)
    (let* ((s (exact (floor p)))
	   (f (- p s))
	   (ns (exact (round (* f 1000000000)))))
      (= 0 (ikarus:nanosleep s ns)))))
