;; udp.ss - (c) rohan drape, 2004-2007

(module
 udp mzscheme
 (require (only "../structure/structure.scm"
		define-structure))

 (define-structure udp* s h p)

 (define (open-udp* h p)
   (make-udp* (udp-open-socket) h p))

 (define (udp*-send u b)
   (let ((s (udp*-s u))
	 (h (udp*-h u))
	 (p (udp*-p u)))
     (udp-send-to* s h p (list->bytes b))))

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
	 (bytes->list (subbytes b 0 (car r)))
	 #f)))

 (provide udp*?
	  open-udp*
	  udp*-send
	  udp*-recv
	  udp*-close))