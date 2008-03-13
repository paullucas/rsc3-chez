;; [sclang] Elements at `l' are spliced into a list.  This is a
;; non-recursive flatten operation.

;; [any|[any]] -> [any]
(define splice 
  (lambda (l)
    (let ((f (lambda (a b)
	       (if (list? a)
		   (append2 a b)
		   (cons a b)))))
      (foldr f nil l))))

;; [sclang] Return a list of `n' places.  If `l' is a list with fewer
;; than `n' elements returns the circular expansion of `l', if `l' is
;; a list with more than `n' elements returns only first `n' elements
;; of `l', if `l'is a list of `n' elements returns `l'.  If `l' is not
;; a list returns a list of `n' elements each being `l'.

(define extend
  (lambda (l n)
    (if (and (list? l) (not (null? l)))
	(let ((z (length l)))
	  (cond ((= z n) l)
		((> z n) (take n l))
		(else (extend (append2 l l) n))))
	(replicate n l))))

;; Extend all lists at `l' to be equal in length to the longest list
;; at `l'.  If any element is not a list it is replaced with a list of
;; itself of that length.

(define extend-all
  (lambda (l)
    (let* ((f (lambda (x) (if (list? x) (length x) 1)))
	   (n (maximum (map1 f l))))
      (map1 (lambda (e) (extend e n)) l))))

;; Return a <list> containing every `n'th element of the list `l' in
;; sequence.

(define take-cycle
  (lambda (l n)
    (if (null? l)
	nil
	(cons (head l)
	      (take-cycle (drop n l) n)))))


;; series

;; Variant allowing function other than '-'.

(define d->dx 
  (lambda (f)
    (lambda (l)
      (unfoldr
       (lambda (x)
	 (if (null? (tail x))
	     #f
	     (tuple2 (f (head (tail x)) (head x)) (tail x))))
       l))))

;; A series, the first element being `n', and subsequent elements
;; summing the previous element with the interval from the interval
;; series `i'.

(define dx->d 
  (lambda (f)
    (lambda (n i)
      (if (null? i)
	  (list1 n)
	  (cons n (dx->d (f (head i) n) (tail i)))))))


;; tree

;; A not entirely naive flatten - ie. does not use append.

(define flatten
  (letrec ((f (lambda (t r)
		(cond ((null? t) r)
		      ((pair? t) (f (head t) (f (tail t) r)))
		      (else (cons t r))))))
    (lambda (t)
      (f t nil))))


;; math

(define clip
  (lambda (a b n) 
    (cond ((< n a) a)
	  ((> n b) b)
	  (else n))))

(define squared 
  (lambda (n)
    (* n n)))

(define cubed 
  (lambda (n)
    (* n n n)))

(define recip 
  (lambda (n)
    (/ 1 n)))

(define e 
  (exp 1.0))

(define pi
  (* 4 (atan 1)))

(define floor-exact
  (compose inexact->exact floor))

(define ceiling-exact
  (compose inexact->exact ceiling))

(define truncate-exact
  (compose inexact->exact truncate))

(define round-exact
  (compose inexact->exact round))

(define log2
  (lambda (x)
    (/ (log (abs x)) (log 2))))

(define log10
  (lambda (x)
    (/ (log x) (log 10))))


;; gain

;; Convert a linear rms gain value to a decibel value and the inverse.
;; Zero decibels is unity gain.  These algorithms are from SC3.

(define ampdb 
  (lambda (x) 
    (* (log10 x) 20)))

(define dbamp
  (lambda (x)
    (expt 10 (* x 0.05))))

(define powdb
  (lambda (x) 
    (* (log10 x) 10)))

(define dbpow
  (lambda (x) 
    (expt 10 (* x 0.1))))


;; pitch

(define (midicps note)
  (* 440.0 (expt 2.0 (* (- note 69.0) 0.083333333333))))

(define (cpsmidi freq)
  (+ (* (log2 (* freq 0.0022727272727)) 12.0) 69.0))

(define (midiratio midi)
  (expt 2.0 (* midi 0.083333333333)))

(define (ratiomidi ratio)
  (* 12.0 (log2 ratio)))

(define (octcps note)
  (* 440.0 (expt 2.0 (- note 4.75))))

(define (cpsoct freq)
  (+ (log2 (* freq 0.0022727272727)) 4.75))

(define degree->key
  (lambda (degree scale steps)
    (let ((scale-n (length scale)))
      (+ (* steps (quotient degree scale-n))
	 (list-ref scale (modulo degree scale-n))))))

;; int -> [any] -> [any]
(define without
  (lambda (n l)
    (append2 (take n l) (drop (+ n 1) l))))

;; [int] -> bool
(define consecutive?
  (lambda (l)
    (let ((x (head l))
	  (xs (tail l)))
      (or (null? xs)
	  (and (= (+ x 1) (head xs))
	       (consecutive? xs))))))

