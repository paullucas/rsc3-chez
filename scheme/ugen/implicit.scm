;; implicit.scm - (c) rohan drape, 2005

;; Gloss, k-rate only, no lag.

(define (implicit-ugen cc)
  (make-ugen 'Control
	     (rate 'k)
	     (list)
	     (map make-output (make-list (length cc) (rate 'k)))
	     0))
