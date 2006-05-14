;; choose.scm - (c) rohan drape, 2005-2006

;; Return a randomly selected element of the <list> 'l'.

(define (choose l)
  (list-ref l (randi 0 (length l))))

;; Weighted choose, w must sum to 1.

(define (windex w n)
  (list-index (lambda (e) (< n e)) (cdr (dx->d 0 w))))

(define (wchoose l w)
  (list-ref l (windex w (rand 0.0 1.0))))

;; Proportional choose, p will be normalized and then wchoosen.

(define (normalize-sum l)
  (let ((n (foldl1 + l)))
    (map (lambda (e) (/ e n)) l)))

(define (pchoose l p)
  (wchoose l (normalize-sum p)))

;; Evaluates to a random element from the proper list `l' as if it
;; were a list distributed with the proportions at `proportions'.
;; This is pchoose with reversed arguments...

(define (choose/proportions proportions l)
  (let* ((p-sum (cdr (dx->d 0 proportions)))
	 (n     (rand 0 (last p-sum))))
    (list-ref l (list-index (lambda (e) (< n e)) p-sum))))

;; Return a randomly selected element of the <string> 's'.

(define (string-choose v)
  (string-ref v (randi 0 (string-length v))))

;; Return a randomly selected element of the <vector> 'v'.

(define (vector-choose v)
  (vector-ref v (randi 0 (vector-length v))))
