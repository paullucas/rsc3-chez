;; routine.scm - (c) rohan drape, 2006-2007

(module routine (lib "lang.ss" "r5rs")
(#%require (only (lib "23.ss" "srfi")
		 error))
(#%provide routine)

(define call/cc call-with-current-continuation)

(define (routine z)
  (let* ((a #f)
	 (b #f)
	 (f (lambda (r)
	      (call/cc (lambda (x)
			 (set! b x)
			 (if (not a)
			     (error "routine: f: a not set?")
			     (a r))))))
	 (g (lambda ()
	      (call/cc (lambda (x)
			 (set! a x)
			 (if b
			     (b)
			     (z f)))))))
    g))

)
