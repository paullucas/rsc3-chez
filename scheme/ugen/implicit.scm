;; implicit.scm - (c) rohan drape, 2005-2006

;; Gloss, k-rate only, no lag.

(define (implicit-ugen cc)
  (make-ugen "Control"
	     kr
	     (list)
	     (map make-output (make-list (length cc) kr))
	     0
	     r0))
