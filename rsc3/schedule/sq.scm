;; sq.scm - (c) rohan drape, 2005-2007

(module sq (lib "lang.ss" "r5rs")
(#%require (only (lib "23.ss" "srfi")
		 error)
	   (only "../structure/structure.scm"
		 define-structure)
	   "pq.scm")
(#%provide (all-defined))

;; k = key, v = value

(define-structure sqe k v)

(define (sqe->list e)
  (list (sqe-k e) (sqe-v e)))

(define (sqe-compare <=)
  (lambda (a b) (<= (sqe-k a) (sqe-k b))))

;; pq = queue, ins = insert, rem = remove

(define-structure sq pq ins rem)

(define (make-sq* <=)
  (let ((f (sqe-compare <=)))
    (make-sq empty-pq
	     (pq-insert f)
	     (pq-remove-min f))))

(define (sq-insert! SQ e)
  (set-sq-pq! SQ ((sq-ins SQ) (sq-pq SQ) e)))

(define (sq-min SQ)
  (pq-min (sq-pq SQ)))

(define (sq-remove-min! SQ)
  (set-sq-pq! SQ ((sq-rem SQ) (sq-pq SQ))))

(define (sq-clear! SQ)
  (set-sq-pq! SQ empty-pq))

(define (sq-empty? SQ)
  (pq-empty? (sq-pq SQ)))

)
