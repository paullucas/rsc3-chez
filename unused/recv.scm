;; port -> float -> [osc]
(define recv*
  (lambda (fd t)
    (let loop ((r (list)))
      (let ((p (recv fd t)))
	(if p (loop (cons p r)) (reverse r))))))

