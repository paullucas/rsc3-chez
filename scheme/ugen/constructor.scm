;; constructor.scm - (c) rohan drape, 2005

;; Rate identifiers.

(define mr -1)
(define ir  0)
(define kr  1)
(define ar  2)

;; If `outputs' is a <number>, evaluate to a <list> of a length
;; determined by consulting the list `inputs' at index `outputs', with
;; `rate' at every location.  Else evaluate to a list having the same
;; elements as the list `outputs', however with each input element
;; that is the symbol 'u' replaced by the value `rate'.

(define (output-rates inputs rate outputs)
  (cond ((number? outputs)
	 (let ((n (ref inputs (floor-exact outputs))))
	   (if (number? n)
	       (make-list (floor-exact n) rate)
	       (error! "output-rates: bad value" outputs))))
	((list? outputs)
	 (map (lambda (e) (if (eq? e 'u) rate e)) outputs))
	(else
	 (error! "output-rates: bad value" outputs))))

;; Ugens that accept a variable number of inputs receive these as a
;; list argument, and this is noted in the default value for that
;; input.  For other inputs a list requires the ugen be extended.
;; This procedure prepares the input list to be sent to the ugen
;; creator.  It first protects all non-list inputs, then removes the
;; output-indicator if one is provided, then flattens the resulting
;; list one level.

(define (inputs-prepare inputs** inputs outputs)
  (let ((inputs* (map (lambda (i d)
			(if (list? (cadr d)) i (list i)))
		      inputs** inputs)))
    (splice
     (if (number? outputs)
	 (remove-index (lambda (e) (= e (floor-exact outputs))) inputs*)
	 inputs*))))

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

;; Evaluates to a procedure that constructs the UGen described by the
;; USpec `uspec'.  The first argument to the returned procedure is the
;; UGen calculation rate.  The second argument specifies the UGen
;; inputs.  Each input may be any valid UGen input value.  If there
;; are fewer input arguments than inputs at the UGen, the default
;; values supplied by the USpec will be used.  If any argument is a
;; symbol naming an input, with an appended colon, the subsequent
;; value is written to that input.

(define (uspec->constructor uspec)
  (let* ((name     (uspec-name/ugen uspec))
	 (inputs   (uspec-inputs uspec))
	 (outputs  (uspec-outputs uspec))
	 (special  (uspec-special uspec))
	 (inputs*  (++ inputs '((mul 1.0) (add 0.0))))
	 (rewriter (lambdaK-rewriter name inputs*)))
    (lambda (rate in)
      (let* ((inputs**  (rewriter in))
	     (inputs*** (drop-right inputs** 2))
	     (mul+add   (take-right inputs** 2))
	     (rate* (if (= rate mr) (fold max 0 (map input-rate inputs**)) rate)))
	(mul-add 
	 (make-ugen/mce
	  name
	  rate*
	  (inputs-prepare inputs*** inputs outputs)
	  (output-rates inputs*** rate* outputs)
	  special)
	 rate* 
	 (car mul+add)
	 (cadr mul+add))))))

;; Accept inputs as variable arguments rather than a list.

(define-syntax define-ugen
  (syntax-rules ()
    ((_ name uspec) 
     (define name 
       (let ((f (uspec->constructor uspec))) 
	 (lambda (rate . inputs) (f rate inputs)))))))
