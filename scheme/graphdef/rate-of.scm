;; rate-of.scm - (c) rohan drape, 2005-2007

(module rate-of (lib "lang.ss" "r5rs")
(#%require (only (lib "23.ss" "srfi")
		 error)
	   "control.scm"
	   "mce.scm"
	   "mrg.scm"
	   "proxy.scm"
	   "rate.scm"
	   "ugen.scm")
(#%provide (all-defined))

(define (rate-of o)
  (cond ((number? o)    ir)
	((control*? o)  (control*-rate o))
	((ugen? o)      (ugen-rate o))
	((proxy? o)     (rate-of (proxy-ugen o)))
	((mce? o)       (rate-select (map rate-of (mce-channels o))))
	((mrg? o)       (error "rate-of: mrg?" o))
	(else           (error "rate-of: illegal value" o))))

)

