;; series.scm - (c) rohan drape, 2000-2007

(module series (lib "lang.ss" "r5rs")
(#%require (only (lib "1.ss" "srfi")
		 unfold))
(#%provide dx->d 
	   d->dx 
	   d->dx**)

;; Predicate to determine if `l' is a one element list.

(define (singleton? l) 
  (and (list? l) (null? (cdr l))))

;; The sequence of intervals between the elements of the series `s'.

(define (d->dx s)
  (d->dx** s -))

;; Variant that considers the interval from the first to last element.

(define (d->dx* s) 
  (d->dx (append s (list (car s)))))

;; Variant allowing function other than '-'.

(define (d->dx** s f)
  (unfold singleton? (lambda (l) (f (cadr l) (car l))) cdr s))

;; A series, the first element being `n', and subsequent elements
;; summing the previous element with the interval from the interval
;; series `i'.

(define (dx->d n i)
  (if (null? i)
      (list n)
      (cons n (dx->d (+ (car i) n) (cdr i)))))

)