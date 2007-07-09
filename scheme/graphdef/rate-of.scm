;; rate-of.scm - (c) rohan drape, 2005-2007

(module rate-of (lib "lang.ss" "r5rs")
(#%require (only (lib "23.ss" "srfi")
		 error)
	   (only "control.scm"
		 control*?
		 control*-rate)
	   (only "mce.scm"
		 mce?
		 mce-channels)
	   (only "mrg.scm"
		 mrg?)
	   (only "proxy.scm"
		 proxy?
		 proxy-ugen)
	   (only "rate.scm"
		 ir
		 rate-select)
	   (only "ugen.scm"
		 ugen?
		 ugen-rate))
(#%provide rate-of)

(define (rate-of o)
  (cond ((number? o)    ir)
	((control*? o)  (control*-rate o))
	((ugen? o)      (ugen-rate o))
	((proxy? o)     (rate-of (proxy-ugen o)))
	((mce? o)       (rate-select (map rate-of (mce-channels o))))
	((mrg? o)       (error "rate-of: mrg?" o))
	(else           (error "rate-of: illegal value" o))))

)

