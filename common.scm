

;; [sclang] Elements at `l' are spliced into a list.  This is a
;; non-recursive flatten operation.

(define splice 
  (lambda (l)
    (let ((f (lambda (a b)
	       (if (list? a)
		   (append a b)
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

;; Clip `n' between a and b.
(define clip
  (lambda (a b n) 
    (if (< n a) a (if (> n b) b n))))

(define (squared n)
  (* n n))

(define (cubed n)
  (* n n n))

(define (recip n)
  (/ 1 n))


;; constants

(define e (exp 1.0))
(define pi (* 4 (atan 1)))
(define two-pi (* 2 pi))
(define half-pi (/ pi 2))

;; SuperCollider names.

(define pi2    half-pi)
(define pi32   (* pi 1.5))
(define twopi  two-pi)
(define rtwopi (/ 1.0 two-pi))
(define log001 (log 0.001))
(define log01  (log 0.01))
(define log1   (log 0.1))
(define rlog2  (/ 1.0 (log 2.0)))
(define sqrt2  (sqrt 2.0))
(define rsqrt2 (/ 1.0 sqrt2))

;; +inf.0 does not write to UGen graph files...

(define inf 1073741824.0)


;; exact

;; Exact integer constructors and predicate.

(define (floor-exact n)    (inexact->exact (floor n)))
(define (ceiling-exact n)  (inexact->exact (ceiling n)))
(define (truncate-exact n) (inexact->exact (truncate n)))
(define (round-exact n)    (inexact->exact (round n)))

;;(define (exact-integer? x) (and (integer? x) (exact? x)))


;; gain

;; Convert a linear rms gain value to a decibel value and the inverse.
;; Zero decibels is unity gain.  These algorithms are from SC3.

(define (ampdb amp) (* (log10 amp) 20))
(define (dbamp db)  (expt 10 (* db 0.05)))

(define (powdb pow) (* (log10 pow) 10))
(define (dbpow db)  (expt 10 (* db 0.1)))


;; log

(define (log* n)         (if (zero? n) n (log n)))
(define (log2 x)         (/ (log (abs x)) (log 2)))
(define (log10 x)        (/ (log x) (log 10)))


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


;; choose

;; Return a randomly selected element of the <list> 'l'.

(define (choose l)
  (list-ref l (randi 0 (length l))))

;; Return a randomly selected element of the <list> 'l'.

(define (choosel n l)
  (map (lambda (_) (choose l)) (enum-from-to 1 n)))

;; Weighted choose, w must sum to 1.

(define (windex w n)
  (find-index (lambda (e) (< n e)) (cdr ((dx->d +) 0 w))))

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
  (let* ((p-sum (cdr ((dx->d +) 0 proportions)))
	 (n     (rand 0 (last p-sum))))
    (list-ref l (find-index (lambda (e) (< n e)) p-sum))))

;; Return a randomly selected element of the <string> 's'.

(define (string-choose v)
  (string-ref v (randi 0 (string-length v))))

;; Return a randomly selected element of the <vector> 'v'.

(define (vector-choose v)
  (vector-ref v (randi 0 (vector-length v))))


;; distribution

;; Alias SRFI-27 name

;; (define random random-real)

;; Linearly distributed in [0,1) with a mean value of 0.2929.  The
;; density function is given by 'f(x) = 2 * (1 - x)'.

(define (random-linear) (min (random) (random)))

;; Linearly distributed in [0,1) with a mean value of 0.6969.  The
;; density function is given by 'f(x) = 2 * (x - 1)'.

(define (random-inverse-linear) (max (random) (random)))

;; Triangularly distributed in [0,1) with a mean value of 0.5.

(define (random-triangular) (* 0.5 (+ (random) (random))))

;; Exponentialy distributed with a mean value of '0.69315 / l'.  There
;; is no upper limit on the value however there is only a one in
;; one-thousand chance of generating a number greater than '6.9078 /
;; l'.  The density function is given by: 'f(x) = l ^ (-l * x)'.

(define (random-exponential l)
  (let ((u (random)))
    (if (zero? u)
	(random-exponential l)
	(/ (- (log u)) l))))

;; Clamped 'random-exponential' in [0,1).

(define (random-exponential*)
  (clip 0.0 1.0 (random-exponential 6.9078)))

;; Bilinear exponentialy distributed with a mean value of 0 and where
;; half of the results lie between '+- 1 / l'.  The density function
;; is given by: 'f(x) = 0.5 * l * (e ^ (-l * |x|))'.

(define (random-bilinear-exponential l)
  (let ((u (* 2 (random))))
    (if (zero? u)
	(random-bilinear-exponential l)
	(* (if (> u 1) -1 1) (log (if (> u 1) (- 2 u) u))))))

;; Guassian distributed with a mean value of `mu' and where 68.26% of
;; values will occur within the interval +-`sigma' and 99.75% within
;; the interval +-(3 * `sigma').  The density function is given by:
;; 'f(x) = (1 / SQRT (2 * pi * sigma)) EXP - ((x - u) ^ 2) / (s *
;; (sigma ^ 2))'.

(define (random-guassian sigma mu)
  (let* ((n 12)
	 (half-n (/ n 2))
	 (scale (/ 1 (sqrt (/ n 12)))))
    (let ((s (sum (map (lambda (_) (random)) (enum-from-to 1 n)))))
      (+ (* sigma scale (- s half-n)) mu))))

;; Clamped 'random-guassian' in [0,1).

(define (random-guassian*)
  (clip 0.0 1.0 (random-guassian (/ 1.0 6.0) 0.5)))

;; Cauchy-distributed with a mean value of 0.0 where half of the
;; results lie in the interval +-alpha, and 99.9% fall within
;; +-318.3alpha.  The density function is given by: 'f(x) = alpha /
;; (pi * (alpha ^ 2 + x ^ 2))'.

(define (random-cauchy alpha)
  (let ((u (random)))
    (if (= u 0.5)
	(random-cauchy alpha)
	(* alpha (tan (* u pi))))))

;; Beta-distributed in [0,1).

(define (random-beta a b)
  (let ((u1 (random)))
    (if (zero? u1)
	(random-beta a b)
	(let ((u2 (random)))
	  (if (zero? u2)
	      (random-beta a b)
	      (let* ((y1 (expt u1 (/ 1 a)))
		     (y2 (expt u2 (/ 1 b)))
		     (sum (+ y1 y2)))
		(if (> sum 1.0)
		    (random-beta a b)
		    (/ y1 sum))))))))

;; Weibull-distributed.

(define (random-weibull s t)
  (let ((u (random)))
    (if (or (zero? u)
	    (= u 1.0))
	(random-weibull s t)
	(let ((a (/ 1.0 (- 1.0 u))))
	  (* s (expt (log a) (/ 1.0 t)))))))

;; Poisson-distributed.

(define (random-poisson l)
  (let loop ((v (exp (- l)))
	     (u (random))
	     (n 0))
    (if (>= u v)
	(loop v (* u (random)) (+ n 1))
	n)))


;; range

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
  (map1 (lambda (_) (rand l r)) 
	(enum-from-to 1 n)))

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
  (map1 (lambda (_) (randx l r)) 
	(enum-from-to 1 n)))

;; Boolean variant.

(define (randb) (> 0.5 (rand 0.0 1.0)))

;; Evaluates to a number that lies within deviation from `center'
;; calculated by multiplying `perturbation' by `center'.

(define (randp center perturbation)
  (let ((deviation (* center perturbation)))
    (rand (- center deviation) (+ center deviation))))


;; shuffle

;; Return a random permutation of the <list> `l'.  This is not a
;; mutation operation.  For a critique of this method see
;; http://okmij.org/ftp/Haskell/perfect-shuffle.txt.

(define (shuffle l)
  (let ((q (map (lambda (e) (cons (rand 0 1) e)) l))
	(c (lambda (a b) (> (car a) (car b)))))
    (map cdr (list-sort q c))))

;; sclang name for shuffle.

(define scramble shuffle)
