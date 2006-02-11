;;;; This code is in the public domain.
;;;;
;;;; Darius Bacon <darius@accesscom.com>
;;;; http://www.accesscom.com/~darius

;; Some minor alterations - in particular delete <=? where not used.

(define make-pq cons)
(define pq/elem car)
(define pq/rest cdr)

(define empty-pq '())
(define pq-empty? null?)

(define (pq-min pq)
  (if (pq-empty? pq)
      (error "pq-min: empty queue")
      (pq/elem pq)))

(define (unit-pq <=?)
  (lambda (elem)
    (make-pq elem '())))

(define (pq-merge <=?)
  (lambda (pq1 pq2)
    (cond ((pq-empty? pq1) pq2)
	  ((pq-empty? pq2) pq1)
	  (else (let ((min1 (pq/elem pq1))
		      (min2 (pq/elem pq2)))
		  (if (<=? min1 min2)
		      (make-pq min1 (cons pq2 (pq/rest pq1)))
		      (make-pq min2 (cons pq1 (pq/rest pq2)))))))))

(define (pq-insert <=?)
  (lambda (pq elem)
    (cond ((pq-empty? pq) (make-pq elem '()))
	  (else (let ((min1 (pq/elem pq))
		      (min2 elem))
		  (if (<=? min1 min2)
		      (make-pq min1 (cons (make-pq elem '()) (pq/rest pq)))
		      (make-pq min2 (cons pq '()))))))))

(define (pq-remove-min <=?)
  (let ((merge (pq-merge <=?)))
    (lambda (pq)
      (if (pq-empty? pq)
	  (error "pq-remove-min: empty queue")
	  (let loop ((pqs (pq/rest pq)))
	    (cond ((null? pqs) empty-pq)
		  ((null? (cdr pqs)) (car pqs))
		  (else (merge
			 (let* ((pq1 (car pqs))
				(pq2 (cadr pqs))
				(min1 (pq/elem pq1))
				(min2 (pq/elem pq2)))
			   (if (<=? min1 min2)
			       (make-pq min1 (cons pq2 (pq/rest pq1)))
			       (make-pq min2 (cons pq1 (pq/rest pq2)))))
			 (loop (cddr pqs))))))))))

