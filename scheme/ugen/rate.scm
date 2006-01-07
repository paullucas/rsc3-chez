;; rate.scm - (c) rohan drape, 2005

(define mr -1)
(define ir  0)
(define kr  1)
(define ar  2)

(define (rate-of o)
  (cond ((number? o)    ir)
	((control*? o)  (control*-rate o))
	((ugen? o)      (ugen-rate o))
	((proxy? o)     (ugen-rate (proxy-ugen o)))
	((mce? o)       (maximum (map rate-of (mce-values o))))
	(else           (error! "rate-of: illegal value" o))))
