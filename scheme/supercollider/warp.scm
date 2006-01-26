;; warp.scm - (c) rohan drape, 2003-2006

;; A warp is a procedure of two arguments.  The first is the <symbol>
;; direction of the warp, which should be either 'map' or 'unmap'.
;; The second is a <real> number.  Warps map from the space [0,1] to a
;; user defined space [minima,maxima].  A warp generator takes the
;; arguments `minima' and `maxima', even if it then ignores these
;; values.

;; Returns true iff the <symbol> `s' is 'map'. 

(define (warp-fwd? s) (eq? s 'map))

;; A linear real value map.

(define (warp-linear minima maxima)
  (let ((range (- maxima minima)))
    (lambda (direction value)
      (if (warp-fwd? direction)
	  (+ (* value range) minima)
	  (/ (- value minima) range)))))

;; A linear integer value map.

(define (warp-linear-integer minima maxima)
  (let ((w (warp-linear minima maxima)))
    (lambda (direction value)
      (round-exact (w direction value)))))

;; The minima and maxima must both be non zero and have the same sign.

(define (warp-exponential minima maxima)
  (let ((ratio (/ maxima minima)))
    (lambda (direction value)
      (if (warp-fwd? direction)
	  (* (expt ratio value) minima)
	  (/ (log (/ value minima)) (log ratio))))))

;; Evaluates to a warp generator for warps with an exponetial curve
;; given by `curve'.

(define (warp-make-warp-curve curve)
  (lambda (minima maxima)
    (let ((range (- maxima minima)))
      (if (< (abs curve) 0.001)
	  (warp-linear minima range)
	  (let* ((grow (exp curve))
		 (a (/ range (- 1.0 grow)))
		 (b (+ minima a)))
	    (lambda (direction value)
	      (if (warp-fwd? direction)
		  (- b (* a (expt grow value)))
		  (/ (log (/ (- b value) a)) curve))))))))

(define (warp-cosine minima maxima)
  (let* ((range (- maxima minima))
	 (linear (warp-linear minima range)))
    (lambda (direction value)
      (if (warp-fwd? direction)
	  (linear 'map (- 0.5 (* (cos (* pi value)) 0.5)))
	  (/ (acos (- 1.0 (* (linear 'unmap value) 2))) pi)))))

(define (warp-sine minima maxima)
  (let* ((range (- maxima minima))
	 (linear (warp-linear minima range)))
    (lambda (direction value)
      (if (warp-fwd? direction)
	  (linear 'map (sin (* half-pi value)))
	  (/ (asin (linear 'unmap value)) half-pi)))))

;; The minima and maxima values are ignored, they are implicitly zero
;; and one.

(define (warp-fader minima maxima)
  (lambda (direction value)
    (if (warp-fwd? direction)
	(* value value)
	(sqrt value))))

;; The minima and maxima values are ignored, they are implicitly
;; negative infinity and zero.  An input value of zero gives -180.

(define (warp-db-fader minima maxima)
  (lambda (direction value)
    (if (warp-fwd? direction)
	(if (zero? value) 
	    -180
	    (ampdb (* value value)))
	(sqrt (dbamp value)))))

;; Translate a symbolic warp name to a warp procedure.

(define (symbol->warp s)
  (case s
    ((lin linear) warp-linear)
    ((exp exponential) warp-exponential)
    ((sin) warp-sine)
    ((cos) warp-cosine)
    ((amp) warp-fader)
    ((db) warp-db-fader)
    (else (error "symbol->warp: unknown symbol" s))))

;; Translate a number to a warp.

(define (number->warp n) (warp-make-warp-curve n))
