;; proxied.scm - (c) rohan drape, 2005

(define (make-ugen/proxies name rate inputs outputs special)
  (let ((u (make-ugen* name rate inputs outputs special))
	(n (length outputs)))
    (if (< n 2)
	u
	(map (lambda (i) (make-output-proxy u i)) (iota n)))))
