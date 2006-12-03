;; range.scm - (c) rohan drape, 2005-2006

;; Parameter to control distribution.

(define current-rand (make-parameter random))

;; Evaluates to a random number with range [a,b) with the distribution
;; determined by `r'.

(define (rand a b) (+ (* ((current-rand)) (- b a)) a))

;; Zero to `n' variant, named for SC3 operator, which is so named due
;; to conflict with SC3 UGen.

(define (_rand n)
  (rand 0 n))

;; -`n' to `n' variant, SC3 naming.

(define (rand2 n)
  (rand (- n) n))

;; List generating variant of rand.

(define (randl n l r) 
  (map (lambda (i) (rand l r)) (iota n)))

;; Integer variant.

(define (randi a b) (floor-exact (rand a b)))

;; Complex variant.

(define (randc a b d e) (make-rectangular (rand a b) (rand d e)))

;; Exponential variant, very common in music work.

(define (randx minima maxima)
  (let ((ratio (/ maxima minima)))
    (* (expt ratio (rand 0.0 1.0)) minima)))

;; List generating variant of randx.

(define (randxl n l r) 
  (map (lambda (i) (randx l r)) (iota n)))

;; Boolean variant.  

(define (randb) (> 0.5 (rand 0.0 1.0)))

;; Evaluates to a number that lies within deviation from `center'
;; calculated by multiplying `perturbation' by `center'.

(define (randp center perturbation)
  (let ((deviation (* center perturbation)))
    (rand (- center deviation) (+ center deviation))))

