;; proxy.scm - (c) rohan drape, 2003-2007

(module proxy (lib "lang.ss" "r5rs")
(#%require (only "../structure/structure.scm"
		 define-structure))
(#%provide make-proxy 
	   proxy? 
	   proxy-ugen 
	   proxy-port)

;; An <mce> of <proxy> records represents a UGen with multiple
;; outputs.

(define-structure proxy ugen port)

)
