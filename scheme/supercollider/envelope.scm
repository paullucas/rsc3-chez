;; envelope.scm - (c) rohan drape, 2003-2005

;; Make a <list> for use with the EnvGen UGen. `levels' is a <list>
;; containing the left to right gain values for the envelope, it has
;; one more element than the <list> `times', having the delta times
;; for each envelope segment.  `curve' is either a symbol or a number
;; or a <list> of such, in either case it is expanded to a list of the
;; same length as `times'.  `release-node' is the index of the
;; 'release' stage of the envelope, `loop-node' is the index of the
;; 'loop' stage of the envelope.  These indices are set as invalid, by
;; convention -1, to indicate there is no such node.

(defineK (Env (levels (0.0 1.0 0.0)) 
	      (times (1.0 1.0)) 
	      (curve linear) 
	      (release-node -1) 
	      (loop-node -1))
  (++ (list (car levels) (length times) release-node loop-node)
      (splice (map (lambda (l t c)
		     (list l 
			   t 
			   (Env.curve->shape c) 
			   (Env.curve->value c)))
		   (cdr levels) times (extend curve (length times))))))

;; Co-ordinate based static envelope generator.

(defineK (Env.bp (bp (0.0 1.0 1.0 1.0)) (dur 1.0) (amp 1.0))
  (Env (map (lambda (e) (*.gr e amp)) (take-cycle (cdr bp) 2))
       (map (lambda (e) (*.gr e dur)) (d->dx (take-cycle bp 2) -))
       'linear -1 -1))

;; Design a standard trapezoidal envelope.  `shape' determines the
;; sustain time as a proportion of `dur', zero is a triangular
;; envelope, one a rectangular envelope.  `skew' determines the
;; attack/decay ratio, zero is an immediate attack and a slow decay,
;; one a slow attack and an immediate decay.  This implementation
;; builds a zero one breakpoint data set and calls Env.bp.

(defineK (Env.trapezoid (shape 0.0) (skew 0.0) (dur 1.0) (amp 1.0))
  (let* ((x1 (* skew (- 1.0 shape)))
	 (bp (list 0
		   (if (<= skew 0.0) 1.0 0.0)
		   x1
		   1.0
		   (+ shape x1)
		   1.0
		   1.0
		   (if (>= skew 1.0) 1.0 0.0))))
    (Env.bp bp dur amp)))

;; SC3 envelope generators.

(defineK (Env.triangle (dur 1.0) (level 1.0))
  (let ((half-dur (*.gr dur 0.5)))
    (Env (list 0.0 level 0.0) 
	 (list half-dur half-dur))))

(defineK (Env.sine (dur 1.0) (level 1.0))
  (let ((half-dur (*.gr dur 0.5)))
    (Env (list 0.0 level 0.0) 
	 (list half-dur half-dur)
	 'sine)))

(defineK (Env.perc (attackTime 0.01) (releaseTime 1.0) (level 1.0) (curve -4.0))
  (Env (list 0.0 level 0.0) 
       (list attackTime releaseTime)
       curve))

(defineK (Env.adsr (attackTime 0.01) 
		   (decayTime 0.3) 
		   (sustainLevel 0.5) 
		   (releaseTime 1.0) 
		   (peakLevel 1.0) 
		   (curve -4.0) 
		   (bias 0.0))
  (Env (map (lambda (e) (+.gr e bias))
	    (list 0.0 peakLevel (*.gr peakLevel sustainLevel) 0.0))
       (list attackTime decayTime releaseTime)
       curve
       2))

(defineK (Env.asr (attackTime 0.01) 
		  (sustainLevel 1.0)
		  (releaseTime 1.0)
		  (curve -4.0))
  (Env (list 0.0 sustainLevel 0.0)
       (list attackTime releaseTime)
       curve
       1.0))

(defineK (Env.linen (attackTime 0.01) 
		    (sustainTime 1.0) 
		    (releaseTime 1.0) 
		    (level 1.0) 
		    (curve linear))
  (Env (list 0.0 level level 0.0)
       (list attackTime sustainTime releaseTime)
       curve))

;; A curve specification is either a symbol or a number.  If it is a
;; symbol it must name a known curve type.  For numerical valued
;; curves the shape '5' indicates the actual curve input value
;; is to be used.

(define (Env.curve->shape curve)
  (if (symbol? curve)
      (case curve
	((step)            0.0)
	((lin linear)      1.0)
	((exp exponential) 2.0)
	((sin sine)        3.0)
	((cos)             4.0)
	((sqr squared)     6.0)
	((cubed)           7.0)
	(else              (error! "Env.curve->shape:" curve)))
      5.0))

;; If the curve is a number the value is that number, else the value
;; will be ignored and is here set to zero.

(define (Env.curve->value curve)
  (if (number? curve) curve 0.0))
