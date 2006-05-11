;; verify.scm - (c) rohan drape, 2005-2006

;; Validating constructors.

(define (message c . l)
  (if (string? c)
      (cons c l)
      (error "message: illegal command" c)))

(define (bundle t . l)
  (if (number? t)
      (cons t l)
      (error "bundle: illegal timestamp" t)))

;; Predicates for OSC packet types.

(define (message? p)
  (string? (car p)))

(define (bundle? p)
  (number? (car p)))

;; Evaluates to '#t' iff `m' is a correct OSC message.  The first
;; element must be a string 'address', subsequent elements are
;; arguments of types integer, real or string.

(define (verify-message m)
  (and (string? (car m))
       (not (find-tail (lambda (e) (not (or (integer? e)
					    (real? e)
					    (string? e))))
		       (cdr m)))))

;; Evaluates to '#t' iff `b' is a correct OSC bundle.  The first
;; element must be an integer 'timetag', subsequent elements may be OSC
;; messages or OSC bundles.  The timetags of embedded bundles must be
;; greater than or equal to the timetag of the containing bundle.

(define (verify-bundle b)
  (and (integer? (car b))
       (not (find-tail (lambda (e) (not (or (verify-message e)
					    (and (verify-bundle e)
						 (>= (car e) (car b))))))
		       (cdr b)))))

;; Evaluates to '#t' iff `p' is a correct OSC packet.  An OSC packet
;; is either an OSC message or an OSC bundle.

(define (verify-packet p)
  (or (verify-message p)
      (verify-bundle p)))

