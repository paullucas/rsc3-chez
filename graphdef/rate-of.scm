;; rate-of.scm - (c) rohan drape, 2005-2007

(module rate-of scheme/base

(require (only-in "../mzscheme/r6rs.ss")
	 (only-in "control.scm"
		  control*?
		  control*-rate)
	 (only-in "mce.scm"
		  mce?
		  mce-channels)
	 (only-in "mrg.scm"
		  mrg?)
	 (only-in "proxy.scm"
		  proxy?
		  proxy-ugen)
	 (only-in "rate.scm"
		  ir
		  rate-select)
	 (only-in "ugen.scm"
		  ugen?
		  ugen-rate))

(provide rate-of)

(define (rate-of o)
  (cond ((number? o)    ir)
	((control*? o)  (control*-rate o))
	((ugen? o)      (ugen-rate o))
	((proxy? o)     (rate-of (proxy-ugen o)))
	((mce? o)       (rate-select (map rate-of (mce-channels o))))
	((mrg? o)       (error 'rate-of "mrg?" o))
	(else           (error 'rate-of "illegal value" o))))

)

