;; udp.scm - (c) rohan drape, 2003-2006

;; Create a UDP socket and associate with port `p' at host `h'.

(define-structure udp_ s h p)

(define (udp! h p)
  (make-udp_ (udp-open-socket) h p))

(define (udp-send! u b)
  (let ((s (udp_-s u))
	(h (udp_-h u))
	(p (udp_-p u)))
    (udp-send-to* s h p b)))

(define (udp-close! u)
  (udp-close (udp_-s u)))

;; Wait at most `t' seconds for a byte packet at `u'.

(define (udp-recv! u t)
  (let* ((s (udp_-s u))
	 (h (udp_-h u))
	 (p (udp_-p u))
	 (b (make-bytes 8192))
	 (r (sync/timeout t (udp-receive!-evt s b))))
    (if r
	(subbytes b 0 (car r))
	#f)))

(define (udp-drain! u)
  (let loop ()
    (if (udp-recv! u 0)
	(loop)
	#f)))
