;; rate.scm - (c) rohan drape, 2005

(define-structure rate value)

(define ir  (make-rate 0))
(define kr  (make-rate 1))
(define ar  (make-rate 2))

(define (rate-select l)
  (let ((f (lambda (a b) (if (> (rate-value a) (rate-value b)) a b))))
    (foldl1 f l)))

(define (rate-of o)
  (cond ((number? o)    ir)
	((control*? o)  (control*-rate o))
	((ugen? o)      (ugen-rate o))
	((proxy? o)     (ugen-rate (proxy-ugen o)))
	((mce? o)       (rate-select (map rate-of (mce-values o))))
	(else           (error! "rate-of: illegal value" o))))
