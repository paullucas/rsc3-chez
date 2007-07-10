;; rate.scm - (c) rohan drape, 2005-2007

(module rate (lib "lang.ss" "r5rs")
(#%require (only "../structure/structure.scm"
		 define-structure)
	   (only "../collection/list.scm"
		 foldl1)
	   (only (lib "23.ss" "srfi")
		 error))
(#%provide rate?
	   rate-select 
	   rate-value
	   ar 
	   kr 
	   ir 
	   dr)

(define-structure rate value)

(define ir (make-rate 0))
(define kr (make-rate 1))
(define ar (make-rate 2))
(define dr (make-rate 3))

;; Order rates for determing the result of math operators.  Operators
;; involving a Demand rate UGen operate at Demand rate.

(define (rate->ordinal r)
  (cond ((eq? r ir)  0)
	((eq? r kr)  1)
	((eq? r ar)  2)
	((eq? r dr)  3)
	(else        (error "illegal rate"))))

(define (rate-select* a b)
  (let ((a* (rate->ordinal a))
	(b* (rate->ordinal b)))
    (if (> a* b*) a b)))

(define (rate-select l)
  (foldl1 rate-select* l))

)
