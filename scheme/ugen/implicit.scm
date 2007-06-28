;; implicit.scm - (c) rohan drape, 2005-2007

(module implicit (lib "lang.ss" "r5rs")
(#%require (only (lib "1.ss" "srfi")
		 make-list)
	   "../graphdef/id.scm"
	   "../graphdef/output.scm"
	   "../graphdef/rate.scm"
	   "../graphdef/ugen.scm")
(#%provide (all-defined))

;; Gloss, k-rate only, no lag.

(define (implicit-ugen cc)
  (make-ugen "Control"
	     kr
	     (list)
	     (map make-output (make-list (length cc) kr))
	     0
	     (make-uid 0)))

)
