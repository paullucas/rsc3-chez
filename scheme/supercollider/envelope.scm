;; envelope.scm - (c) rohan drape, 2003-2006

;; A curve specification is either a <string> or a <number>.  If it is
;; a string it must name a known curve type.  For numerical valued
;; curves the shape '5' indicates the actual curve input value is to
;; be used.

(define (curve->shape curve)
  (cond ((string? curve)
	 (let ((f (lambda (s) (string=? s curve))))
	   (cond
	    ((f "step")        0.0)
	    ((f "linear")      1.0)
	    ((f "exponential") 2.0)
	    ((f "sin")         3.0)
	    ((f "cos")         4.0)
	    ((f "squared")     6.0)
	    ((f "cubed")       7.0)
	    (else              (error "curve->shape:" curve)))))
	((number? curve)
	 curve)
	(else
	 (error "curve->shape: illegal curve" curve))))

;; If the curve is a number the value is that number, else the value
;; will be ignored and is here set to zero.

(define (curve->value curve)
  (if (number? curve) curve 0.0))

;; Make a <list> for use with the EnvGen UGen. `levels' is a <list>
;; containing the left to right gain values for the envelope, it has
;; one more element than the <list> `times', having the delta times
;; for each envelope segment.  `curve' is either a string or a number
;; or a <list> of such, in either case it is expanded to a list of the
;; same length as `times'.  `release-node' is the index of the
;; 'release' stage of the envelope, `loop-node' is the index of the
;; 'loop' stage of the envelope.  These indices are set as invalid, by
;; convention -1, to indicate there is no such node.

(define (env levels times curve release-node loop-node)
  (make-mce
   (append 
    (list (car levels) (length times) release-node loop-node)
    (splice (map (lambda (l t c)
		   (list l
			 t
			 (curve->shape c)
			 (curve->value c)))
		 (cdr levels) times (extend curve (length times)))))))

;; Co-ordinate based static envelope generator.

(define (env/bp bp dur amp)
  (env (map (lambda (e) (Mul e amp)) (take-cycle (cdr bp) 2))
       (map (lambda (e) (Mul e dur)) (d->dx** (take-cycle bp 2) Sub))
       'linear
       -1
       -1))

;; Design a standard trapezoidal envelope.  `shape' determines the
;; sustain time as a proportion of `dur', zero is a triangular
;; envelope, one a rectangular envelope.  `skew' determines the
;; attack/decay ratio, zero is an immediate attack and a slow decay,
;; one a slow attack and an immediate decay.  This implementation
;; builds a zero one breakpoint data set and calls env/bp.

(define (env/trapezoid shape skew dur amp)
  (let* ((x1 (* skew (- 1.0 shape)))
	 (bp (list 0
		   (if (<= skew 0.0) 1.0 0.0)
		   x1
		   1.0
		   (+ shape x1)
		   1.0
		   1.0
		   (if (>= skew 1.0) 1.0 0.0))))
    (env/bp bp dur amp)))

;; SC3 envelope generators.

(define (env/triangle dur level)
  (let ((half-dur (Mul dur 0.5)))
    (env (list 0.0 level 0.0)
	 (list half-dur half-dur)
	 "linear"
	 -1
	 -1)))

(define (env/sine dur level)
  (let ((half-dur (Mul dur 0.5)))
    (env (list 0.0 level 0.0)
	 (list half-dur half-dur)
	 "sin"
	 -1
	 -1)))

(define (env/perc attackTime releaseTime level curve)
  (env (list 0.0 level 0.0)
       (list attackTime releaseTime)
       curve
       -1
       -1))

(define (env/adsr attackTime
		  decayTime
		  sustainLevel
		  releaseTime
		  peakLevel
		  curve
		  bias)
  (env (map (lambda (e) (Mul e bias))
	    (list 0.0 peakLevel (Mul peakLevel sustainLevel) 0.0))
       (list attackTime decayTime releaseTime)
       curve
       2
       -1))

(define (env/asr attackTime sustainLevel releaseTime curve)
  (env (list 0.0 sustainLevel 0.0)
       (list attackTime releaseTime)
       curve
       1
       -1))

(define (env/linen attackTime sustainTime releaseTime level curve)
  (env (list 0.0 level level 0.0)
       (list attackTime sustainTime releaseTime)
       curve
       -1
       -1))
