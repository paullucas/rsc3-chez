
;; signal

;; n element segments at intervals of k from l
(define segment
  (lambda (n k l)
    (let ((s (take n l)))
      (if (null? s)
	  s
	  (cons s (segment n k (drop k l)))))))

;; A Signal is half the size of a Wavetable, each element is the sum
;; of two adjacent elements of the Wavetable.

(define wavetable->signal
  (lambda (l)
    (concat-map sum (segment 2 2 l))))

;; A Wavetable is twice the size of a Signal. Each element 'e0'
;; expands to {2*e0-e1, e1-e0} where e1 is the next element.

(define signal->wavetable
  (lambda (l)
    (let ((f (lambda (e0 e1) (list (- (* 2.0 e0) e1) (- e1 e0)))))
      (concat-map f (segment 1 2 (append2 l (list1 (head l))))))))

