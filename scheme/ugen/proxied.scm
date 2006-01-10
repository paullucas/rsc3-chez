;; proxied.scm - (c) rohan drape, 2005

(define (make-ugen/proxies name rate inputs outputs special id)
  (let ((u (make-ugen name rate inputs outputs special id))
	(n (length outputs)))
    (if (< n 2)
	u
	(make-mce (map (lambda (i) (make-proxy u i)) (iota n))))))
