;; define.scm - (c) rohan drape, 2000-2006

;; An interface to match-let. Restricted to <pairs>, <list>s,
;; <vector>s and <struct>s - and *without* an implicit begin.  The
;; struct syntax is abbreviated, it does not require the 'struct'
;; keyword or the parentheses around the fields.

(define-syntax letM1
  (lambda (stx)
    (syntax-case*
     stx (list cons vector) module-or-top-identifier=?
     ((_ (list n ...) v e)   (syntax (match-let (((list n ...) v)) e)))
     ((_ (cons n0 n1) v e)   (syntax (match-let (((list-rest n0 n1) v)) e)))
     ((_ (vector n ...) v e) (syntax (match-let (((vector n ...) v)) e)))
     ((_ (type n ...) v e)   (syntax (match-let (((struct type (n ...)) v)) e)))
     ((_ n v e)              (syntax (let ((n v)) e))))))

(define-syntax letM*
  (syntax-rules ()
    ((_ ((n v)) e)               (letM1 n v e))
    ((_ ((n0 v0) (n1 v1) ...) e) (letM1 n0 v0 (letM* ((n1 v1) ...) e)))))

(define-syntax lambdaMl
  (syntax-rules ()
    ((_ l (n)        e) (l (v)        (letM* ((n v))                   e)))
    ((_ l (n0 n1)    e) (l (v0 v1)    (letM* ((n0 v0) (n1 v1))         e)))
    ((_ l (n0 n1 n2) e) (l (v0 v1 v2) (letM* ((n0 v0) (n1 v1) (n2 v2)) e)))
    ;; ...
    ((_ l (n0 n1 n2 n3) e) (l (v0 v1 v2 v3) (letM* ((n0 v0) (n1 v1) (n2 v2) (n3 v3)) e)))
    ((_ l (n0 n1 n2 n3 n4) e) (l (v0 v1 v2 v3 v4) (letM* ((n0 v0) (n1 v1) (n2 v2) (n3 v3) (n4 v4)) e)))
    ((_ l (n0 n1 n2 n3 n4 n5) e) (l (v0 v1 v2 v3 v4 v5) (letM* ((n0 v0) (n1 v1) (n2 v2) (n3 v3) (n4 v4) (n5 v5)) e)))
    ((_ l (n0 n1 n2 n3 n4 n5 n6) e) (l (v0 v1 v2 v3 v4 v5 v6) (letM* ((n0 v0) (n1 v1) (n2 v2) (n3 v3) (n4 v4) (n5 v5) (n6 v6)) e)))
    ((_ l (n0 n1 n2 n3 n4 n5 n6 n7) e) (l (v0 v1 v2 v3 v4 v5 v6 v7) (letM* ((n0 v0) (n1 v1) (n2 v2) (n3 v3) (n4 v4) (n5 v5) (n6 v6) (n7 v7)) e)))
    ((_ l (n0 n1 n2 n3 n4 n5 n6 n7 n8) e) (l (v0 v1 v2 v3 v4 v5 v6 v7 v8) (letM* ((n0 v0) (n1 v1) (n2 v2) (n3 v3) (n4 v4) (n5 v5) (n6 v6) (n7 v7) (n8 v8)) e)))
    ((_ l (n0 n1 n2 n3 n4 n5 n6 n7 n8 n9) e) (l (v0 v1 v2 v3 v4 v5 v6 v7 v8 v9) (letM* ((n0 v0) (n1 v1) (n2 v2) (n3 v3) (n4 v4) (n5 v5) (n6 v6) (n7 v7) (n8 v8) (n9 v9)) e)))
    ((_ l (n0 n1 n2 n3 n4 n5 n6 n7 n8 n9 nA) e) (l (v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 vA) (letM* ((n0 v0) (n1 v1) (n2 v2) (n3 v3) (n4 v4) (n5 v5) (n6 v6) (n7 v7) (n8 v8) (n9 v9) (nA vA)) e)))
    ((_ l (n0 n1 n2 n3 n4 n5 n6 n7 n8 n9 nA nB) e) (l (v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 vA vB) (letM* ((n0 v0) (n1 v1) (n2 v2) (n3 v3) (n4 v4) (n5 v5) (n6 v6) (n7 v7) (n8 v8) (n9 v9) (nA vA) (nB vB)) e)))
    ((_ l (n0 n1 n2 n3 n4 n5 n6 n7 n8 n9 nA nB nC) e) (l (v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 vA vB vC) (letM* ((n0 v0) (n1 v1) (n2 v2) (n3 v3) (n4 v4) (n5 v5) (n6 v6) (n7 v7) (n8 v8) (n9 v9) (nA vA) (nB vB) (nC vC)) e)))
    ((_ l (n0 n1 n2 n3 n4 n5 n6 n7 n8 n9 nA nB nC nD) e) (l (v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 vA vB vC vD) (letM* ((n0 v0) (n1 v1) (n2 v2) (n3 v3) (n4 v4) (n5 v5) (n6 v6) (n7 v7) (n8 v8) (n9 v9) (nA vA) (nB vB) (nC vC) (nD vD)) e)))))

#|

;; The above is appalling - I don't know if this can be done without
;; resort to syntax-case - the above generates the temporaries (vN) by
;; hand...

(define-syntax lambdaMl*
  (syntax-rules ()
    ((_ l (n ...) (v ...) e) (lambda (v ...) (letM* ((n v) ...) e)))
    ;; ...
    ((_ l (n)             e) (lambdaMl* l (n)         (v)         e))
    ((_ l (n0 n1)         e) (lambdaMl* l (n0 n1)     (v0 v1)     e))
    ((_ l (n0 n1 ...)     e) (lambdaMl* l (n0 n1 ...) (v0 v1 ...) e))))

|#

(define-syntax lambdaM
  (syntax-rules ()
    ((_ (n ...) e) (lambdaMl lambda (n ...) e))))

(define-syntax define*
  (syntax-rules ()
    ((_ (n v ...) e) (define n (lambdaM (v ...) e)))
    ((_ n v)         (define n v))))

;; Local Variables:
;; truncate-lines:t
;; End:            
