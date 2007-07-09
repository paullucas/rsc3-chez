;; server.scm - (c) rohan drape, 2003-2007

(module server (lib "lang.ss" "r5rs")
(#%require (only (lib "23.ss" "srfi")
		  error)
	   (only (lib "39.ss" "srfi")
		  make-parameter)
	   (only "../osc/verify.scm"
		 bundle)
	   (only "../osc/transport.scm"
		 osc-send
		 osc-recv)
	   "command.scm")
(#%provide (all-defined))

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
