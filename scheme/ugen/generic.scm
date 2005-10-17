;; generic.scm - (c) rohan drape, 2003-2005

;; Get the rate of the input value `o'.  If `o' is not a UGen, or
;; Output Proxy, or constant, or Control, or list of such, an error is
;; raised.

(define (input-rate o)
  (cond ((number? o)        0)
	((control*? o)      (control*-rate o))
	((ugen? o)          (ugen-rate o))
	((output-proxy? o)  (ugen-rate (output-proxy-ugen o)))
	((list? o)          (apply max (map input-rate o)))
	(else               (error! "input-rate: illegal value" o))))

;; The generic ugen constructor.

(define (ugen-generic ugen inputs)
  (ugen (fold max 0 (map input-rate inputs)) inputs))

(define-syntax define-ugenG 
  (syntax-rules ()
    ((_ ugen ugen.xr) 
     (define ugen (lambda inputs (ugen-generic ugen.xr inputs))))))
