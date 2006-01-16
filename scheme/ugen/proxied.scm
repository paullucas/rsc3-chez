;; proxied.scm - (c) rohan drape, 2005

(defineH proxied u
  (cond
   ((ugen? u) (letH (ugen _ _ _ o _ _) u
		    n (length o)
	        (if (< n 2)
		    u
		    (make-mce (map (lambda (i) (make-proxy u i))
				   (iota n))))))
   ((mce? u)  (make-mce (map proxied (mce-channels u))))))
