;; constructor.scm - (c) rohan drape, 2005

;; name = <string>
;; rate? = <integer> | #f
;; inputs = <list> of <input*>
;; mce? = <input*> | #f
;; outputs = <integer>
;; special = <integer>

(define (construct-ugen name rate? inputs mce? outputs special) 
  (let ((rate (if rate?
		  rate?
		  (maximum (map rate-of inputs))))
	(inputs* (if mce?
		     (++ inputs (mce-force mce?))
		     inputs)))
    (make-ugen/proxies
     (symbol->string name)
     rate
     inputs*
     (make-outputs outputs rate)
     special)))

(define-syntax define-oscillator
  (syntax-rules ()
    ((_ n (i ...) o) 
     (define (n r i ...) 
       (construct-ugen (quote n) r (list i ...) #f o 0)))))

(define (without n l)
  (append (take l n) (drop l (+ n 1))))

(define-syntax define-oscillator-n
  (syntax-rules ()
    ((_ n (i ...) z) 
     (define (n rate i ...)
       (let ((l (list i ...)))
	 (construct-ugen 'n rate (without z l) #f (ref l z) 0))))))

(define-syntax define-oscillator*
  (syntax-rules ()
    ((_ n (i ... v) o)
     (define (n r i ... v) 
       (construct-ugen 'n r (list i ...) v o 0)))))

(define-syntax define-oscillator!
  (syntax-rules ()
    ((_ n (i ...) o)
     (define (n id r i ...) 
       (construct-ugen 'n r (list i ...) #f o 0)))))

(define-syntax define-filter
  (syntax-rules ()
    ((_ n (i ...) o) 
     (define (n i ...)
       (construct-ugen 'n #f (list i ...) #f o 0)))))

(define-syntax define-filter*
  (syntax-rules ()
    ((_ n (i ... v) o) 
     (define (n i ... v)
       (construct-ugen 'n #f (list i ...) v o 0)))))

(define-syntax define-filter!
  (syntax-rules ()
    ((_ n (i ...) o) 
     (define (n id i ...)
       (construct-ugen 'n #f (list i ...) #f o 0)))))

(define-syntax define-unary-operator
  (syntax-rules ()
    ((_ n s) 
     (define (n a)
       (construct-ugen 'UnaryOpUGen #f (list a) #f 1 s)))))

(define-syntax define-binary-operator
  (syntax-rules ()
    ((_ n s) 
     (define (n a b)
       (construct-ugen 'BinaryOpUGen #f (list a b) #f 1 s)))))

(define-syntax define-specialized
  (syntax-rules ()
    ((_ n (i ...) o r)
     (define (n i ...)
       (construct-ugen 'n r (list i ...) #f o 0)))))
