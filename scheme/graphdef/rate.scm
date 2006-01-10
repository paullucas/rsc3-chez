;; rate.scm - (c) rohan drape, 2005

(define-structure rate value)

(defineH ir (make-rate 0))
(defineH kr (make-rate 1))
(defineH ar (make-rate 2))
(defineH dr (make-rate 3))

(defineH rate->ordinal r
  (cond ((eq? r ir)  0)
	((eq? r dr)  1)
	((eq? r kr)  2)
	((eq? r ar)  3)
	(else        (error! "illegal rate"))))

(defineH rate-select* a b
  (let ((a* (rate->ordinal a))
	(b* (rate->ordinal b)))
    (if (> a* b*) a b)))

(defineH rate-select l
  (foldl1 rate-select* l))

(defineH rate-of o
  (cond ((number? o)    ir)
	((control*? o)  (control*-rate o))
	((ugen? o)      (ugen-rate o))
	((proxy? o)     (ugen-rate (proxy-ugen o)))
	((mce? o)       (rate-select (map rate-of (mce-channels o))))
	(else           (error! "rate-of: illegal value" o))))
