;; server.scm - (c) rohan drape, 2003-2007

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
  (-> s (bundle (utc)
		(/g_freeAll 0)
		/clearSched
		(/g_new 1 0 0))))
