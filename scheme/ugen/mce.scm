;; mce.scm - (c) rohan drape, 2005

(define (mce-depth inputs)
  (fold max 0 (map (lambda (e)
		     (cond ((null? e) (error! "mce-depth: null input"))
			   ((list? e) (length e))
			   (else      0)))
		   inputs)))

;; Input replication in SuperCollider is called Multi Channel
;; Expansion (MCE).  If any input is a list, all inputs are expanded
;; to be equal in length to the longest input, and a list of ugens are
;; created, one for each element of each input.  The resulting set of
;; ugens is proxied, possibly resulting in a nested list.  If
;; expansion is required each branch is treated recursively.

(define (make-ugen/mce name rate inputs outputs special)
  (let ((depth (mce-depth inputs)))
    (if (= depth 0)
	(make-ugen/proxies name rate inputs outputs special)
	(let ((inputs* (map (lambda (e) (extend e depth)) inputs)))
	  (map (lambda (i)
		 (make-ugen/mce
		  name 
		  rate 
		  (map (lambda (e) (ref e i)) inputs*)
		  outputs 
		  special))
	       (iota depth))))))
