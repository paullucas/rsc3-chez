;; distribution.scm - (c) rohan drape, 2000-2006

;; Alias SRFI-27 name

(define random random-real)

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
    (let ((sum (apply + (map (lambda (ignored) (random)) (iota n)))))
      (+ (* sigma scale (- sum half-n)) mu))))

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

