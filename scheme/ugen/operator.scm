;; operator.scm - (c) rohan drape, 2005

(define-syntax define-uop
  (syntax-rules ()
    ((_ op ugen) (define (op a) (ugen mr a)))))

(define-uop midicpsu MIDICPS)

(define-syntax define-binop
  (syntax-rules ()
    ((_ op ugen) (define (op a b) (ugen mr a b)))))

(define-binop *u  Mul)
(define-binop +u  Add)
(define-binop -u  Sub)
(define-binop /u  FDiv)
(define-binop %u  Mod)
(define-binop =u  EQ)
(define-binop <u  LT)
(define-binop >u  GT)
(define-binop <=u LE)
(define-binop >=u GE)
