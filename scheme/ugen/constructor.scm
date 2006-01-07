;; constructor.scm - (c) rohan drape, 2005

(define-syntax define-oscillator
  (syntax-rules ()
    ((_ n (i ...) o) 
     (define (n r i ...) 
       (make-ugen/proxies
	(symbol->string (quote n))
	r
	(list i ...) 
	(make-outputs o r)
	0)))))

(define-syntax define-oscillator*
  (syntax-rules ()
    ((_ n (i ... v) o)
     (define (n r i ... v) 
       (make-ugen/proxies
	(symbol->string (quote n))
	r
	(append (list i ...) (mce-force v))
	(make-outputs o r)
	0)))))

(define-syntax define-oscillator!
  (syntax-rules ()
    ((_ n (i ...) o)
     (define (n id r i ...) 
       (make-ugen/proxies
	(symbol->string (quote n))
	r
	(list i ...)
	(make-outputs o r)
	0)))))

(define-syntax define-filter
  (syntax-rules ()
    ((_ n (i ...) o) 
     (define (n i ...)
       (let ((r (maximum (map rate-of (list i ...)))))
	 (make-ugen/proxies 
	  (symbol->string (quote n))
	  r
	  (list i ...) 
	  (make-outputs o r)
	  0))))))

(define-syntax define-filter*
  (syntax-rules ()
    ((_ n (i ... v) o) 
     (define (n i ... v)
       (let* ((i* (append (list i ...) (mce-force v)))
	      (r (maximum (map rate-of i*))))
	 (make-ugen/proxies
	  (symbol->string (quote n))
	  r
	  i*
	  (make-outputs o r)
	  0))))))

(define-syntax define-filter!
  (syntax-rules ()
    ((_ n (i ...) o) 
     (define (n id i ...)
       (let ((r (maximum (map rate-of (list i ...)))))
	 (make-ugen/proxies
	  (symbol->string (quote n))
	  r
	  (list i ...) 
	  (make-outputs o r)
	  0))))))

(define-syntax define-unary-operator
  (syntax-rules ()
    ((_ n s) 
     (define (n a)
       (let ((r (rate-of a)))
	 (make-ugen/proxies
	  "UnaryOpUGen"
	  r
	  (list a)
	  (make-outputs 1 r)
	  s))))))

(define-syntax define-binary-operator
  (syntax-rules ()
    ((_ n s) 
     (define (n a b)
       (let ((r (max (rate-of a) (rate-of b))))
	 (make-ugen/proxies
	  "BinaryOpUGen"
	  r 
	  (list a b) 
	  (make-outputs 1 r)
	  s))))))

(define-syntax define-specialized
  (syntax-rules ()
    ((_ n (i ...) o r)
     (define (n i ...)
       (make-ugen/proxies
	(symbol->string (quote n))
	r
	(list i ...) 
	(make-outputs o r)
	0)))))
