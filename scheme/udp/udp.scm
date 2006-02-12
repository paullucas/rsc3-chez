;; udp.scm - (c) rohan drape, 2003-2006

;; Create a UDP socket and associate with port `p' at host `h'.

(define-structure udp* s h p)

(define (open-udp* h p)
  (make-udp* (udp-open-socket) h p))

(define (udp*-send u b)
  (let ((s (udp*-s u))
	(h (udp*-h u))
	(p (udp*-p u)))
    (udp-send-to* s h p b)))

(define (udp*-close u)
  (udp-close (udp*-s u)))

;; Wait at most `t' seconds for a byte packet at `u'.

(define (udp*-recv u t)
  (let* ((s (udp*-s u))
	 (h (udp*-h u))
	 (p (udp*-p u))
	 (b (make-bytes 8192))
	 (r (sync/timeout t (udp-receive!-evt s b))))
    (if r
	(subbytes b 0 (car r))
	#f)))

(define (udp*-drain u)
  (let loop ()
    (if (udp*-recv u 0)
	(loop)
	#f)))