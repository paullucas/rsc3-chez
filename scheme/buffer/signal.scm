;; signal.scm - (c) rohan drape, 2005-2006

;; A Signal is half the size of a Wavetable, each element is the sum
;; of two adjacent elements of the Wavetable.

(define (wavetable->signal l) 
  (mapw 2 2 + l))

;; A Wavetable is twice the size of a Signal.  Each element 'e0'
;; expands to {2*e0-e1, e1-e0} where e1 is the next element.

(define (signal->wavetable l)
  (let ((f (lambda (e0 e1) (list (- (* 2.0 e0) e1) (- e1 e0)))))
    (splice (mapw* 2 1 f l))))
