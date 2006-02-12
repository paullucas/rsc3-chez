;; server.scm - (c) rohan drape, 2003-2006

(define -> osc-send)

(define <- osc-recv)

(define (<-* s t)
  (let loop ((r (list)))
    (let ((p (<- s t)))
      (if p (loop (cons p r)) (reverse r)))))

(define (->< s l)
  (let ((r (car l))
	(m (cadr l)))
    (begin
      (let ((q (<-* s 0.0)))
	(if (null? q)
	    #f
	    (begin (display "-><: queued")
		   (display q)
		   (newline))))
      (-> s m)
      (let ((p (<- s 1.0)))
	(cond
	 ((not p)                    (error "-><: timed out"))
	 ((not (string=? (car p) r)) (error "-><: bad return packet" p r))
	 (else                       p))))))

(define (=> s t m)
  (-> s (list t m)))

(define (free-all s)
  (begin
   (-> s (/g_freeAll 0))
   (-> s (/clearSched))
   (-> s (/g_new 1 0 0))))
