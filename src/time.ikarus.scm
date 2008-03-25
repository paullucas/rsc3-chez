;; double -> bool
(define thread-pause
  (lambda (p)
    (let* ((s (exact (floor p)))
	   (f (- p s))
	   (ns (exact (round (* f 1000000000)))))
      (= 0 (nanosleep s ns)))))
