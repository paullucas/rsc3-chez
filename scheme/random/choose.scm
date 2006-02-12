;; choose.scm - (c) rohan drape, 2005-2006

;; Return a randomly selected element of the <list> 'l'.

(define (choose l)
  (ref l (randi 0 (length l))))

;; Evaluates to a random element from the proper list `l' as if it
;; were a list distributed with the proportions at `proportions'.

(define (choose/proportions proportions l)
  (let* ((p-sum (cdr (dx->d 0 proportions)))
	 (n     (rand 0 (last p-sum))))
    (ref l (index (lambda (e) (< n e)) p-sum))))

;; Return a randomly selected element of the <string> 's'.

(define (string-choose v)
  (string-ref v (randi 0 (string-length v))))

;; Return a randomly selected element of the <vector> 'v'.

(define (vector-choose v)
  (vector-ref v (randi 0 (vector-length v))))
