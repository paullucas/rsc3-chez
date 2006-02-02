;; series.scm - (c) rohan drape, 2000-2006

;; The sequence of intervals between the elements of the series `s'.

(define (d->dx s)
  (unfold singleton? (lambda (l) (- (cadr l) (car l))) cdr s))

;; Variant that considers the interval from the first to last element.

(define (d->dx* s) (d->dx (++ s (list (car s)))))

;; A series, the first element being `n', and subsequent elements
;; summing the previous element with the interval from the interval
;; series `i'.

(define (dx->d n i)
  (if (null? i)
      (list n)
      (cons n (dx->d (+ (car i) n) (cdr i)))))
