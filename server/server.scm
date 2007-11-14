;; server.scm - (c) rohan drape, 2003-2007

(module server scheme/base

(require ;; (only-in srfi/23
	 ;; 	  error)
	 (only-in srfi/39
		  make-parameter)
	 (only-in "../osc/verify.scm"
		  bundle)
	 (only-in "../osc/transport.scm"
		  osc-send
		  osc-recv)
	 "command.scm")

(provide (all-defined-out))

(define -> osc-send)

(define <- osc-recv)

(define (<-* s t)
  (let loop ((r (list)))
    (let ((p (<- s t)))
      (if p (loop (cons p r)) (reverse r)))))

(define timeout (make-parameter 1.0))

(define (->< s l)
  (let ((r (car l))
	(m (cadr l)))
    (-> s m)
    (let ((p (<- s (timeout))))
      (cond
       ((not p)                    (error "-><: timed out"))
       ((not (string=? (car p) r)) (error "-><: bad return packet" p r))
       (else                       p)))))

(define (reset s)
  (-> s (bundle -1
		(/g_freeAll 0)
		/clearSched
		(/g_new 1 0 0))))

)
