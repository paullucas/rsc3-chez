;; uspec.scm - (c) rohan drape, 2003-2005

;; USpecs describe UGens.  

(define-structure uspec name inputs outputs special rates)

;; name = either a symbol or a duple (Name Implementation).  The
;; naming situation is complicated by two issues: all unary and binary
;; math operators are implemented by the UGens 'UnaryMathOp' and
;; 'BinaryMathOp'.  There are name conflicts between the operator
;; names as given in the sc3 code base and provided UGens (Rand,
;; LinRand and Ramp).

;; input = a duple (Name Default).  If the default value of the last
;; input is a list that input is flattened and sent as multiple inputs
;; to the UGen, which must accept a variable number of inputs.

;; outputs = normally a list that describes the rate of each output
;; port, values are either rate specifiers or the symbol 'u' to
;; indicate the output rate should be the same as the UGen rate.  If
;; the output descriptor is instead an integer, the UGen has a
;; variable number of outputs, and the value indicates the input to
;; read the number of outputs from.  All outputs will be at the rate
;; of the UGen, and the input describing the number of outputs will be
;; removed from the input list.

;; special = an integer index defined only for unary and binary math
;; operators.

;; rates = a list of integer rate specifiers the UGen can operate at.

(define-syntax define-uspec
  (syntax-rules ()
    ((_ n.u n i o s r) (define n.u (make-uspec 'n 'i 'o 's 'r)))
    ((_ n.u n i o s)   (define n.u (make-uspec 'n 'i 'o 's '(0 1 2))))))

;; Name accessors.

(define (uspec-name/ugen s)
  (let ((n (uspec-name s)))
    (if (list? n) (cadr n) n)))

(define (uspec-name/constructor s)
  (let ((n (uspec-name s)))
    (if (list? n) (car n) n)))

;; Input accessors.

(define (uspec-input-name i)    (first i))
(define (uspec-input-default i) (second i))

;; Variadic predicates.

(define (uspec-has-variable-inputs? s)
  (list? (uspec-input-default (last (uspec-inputs s)))))

(define (uspec-has-variable-outputs? s)
  (not (list? (uspec-outputs s))))

;; Construct a usage list for the USpec `s'.

(define (uspec-usage s . defaults)
  (cons (uspec-name/constructor s)
	(if (null? defaults)
	    (map uspec-input-name (uspec-inputs s))
	    (uspec-inputs s))))

