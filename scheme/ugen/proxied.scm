;; proxied.scm - (c) rohan drape, 2005-2006

(define (proxied u)
  (cond
   ((ugen? u) (let* ((o (ugen-outputs u))
		     (n (length o)))
	        (if (< n 2)
		    u
		    (make-mce (map (lambda (i) (make-proxy u i))
				   (iota n))))))
   ((mce? u)  (make-mce (map proxied (mce-channels u))))))
