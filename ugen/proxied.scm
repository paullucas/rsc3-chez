;; proxied.scm - (c) rohan drape, 2005-2007

(module proxied scheme/base

(require (only-in srfi/1
		  iota)
	 "../graphdef/mce.scm"
	 "../graphdef/proxy.scm"
	 "../graphdef/ugen.scm")

(provide (all-defined-out))

(define (proxied u)
  (cond
   ((ugen? u) (let* ((o (ugen-outputs u))
		     (n (length o)))
	        (if (< n 2)
		    u
		    (make-mce (map (lambda (i) (make-proxy u i))
				   (iota n))))))
   ((mce? u)  (make-mce (map proxied (mce-channels u))))))

)
