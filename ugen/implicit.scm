;; implicit.scm - (c) rohan drape, 2005-2007

(module implicit scheme/base

(require (only-in srfi/1
		  make-list)
	 "../graphdef/id.scm"
	 "../graphdef/output.scm"
	 "../graphdef/rate.scm"
	 "../graphdef/ugen.scm")

(provide (all-defined-out))

;; Gloss, k-rate only, no lag.

(define (implicit-ugen cc)
  (make-ugen "Control"
	     kr
	     (list)
	     (map make-output (make-list (length cc) kr))
	     0
	     (make-uid 0)))

)
