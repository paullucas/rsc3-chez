;; ugenS.scm - (c) rohan drape, 2005

;; Construct a list of s-expressions that make ugen procedures from
;; the USpec `s' and bind rate specializations of these procedures to
;; symbols with the appropriate rate suffixes.

(define-syntax define-ugenS
  (syntax-rules ()
    ((_ ugen ugen.xr n) 
     (define ugen (lambda args (ugen.xr n args))))))
