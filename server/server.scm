;; server.scm - (c) rohan drape, 2003-2008

(module server scheme/base

(require ;; (only-in srfi/23
	 ;; 	  error)
	 (only-in srfi/39
		  make-parameter)
	 (only-in "../mzscheme/udp.ss"
		  open-udp*
		  udp*-close)
	 (only-in "../osc/verify.scm"
		  bundle)
	 (only-in "../osc/transport.scm"
		  osc-send
		  osc-recv)
	 "command.scm")

(provide (all-defined-out))

(define send osc-send)

(define recv osc-recv)

(define (recv* fd t)
  (let loop ((r (list)))
    (let ((p (recv fd t)))
      (if p (loop (cons p r)) (reverse r)))))

(define timeout (make-parameter 1.0))

(define (wait fd m)
  (let ((p (recv fd (timeout))))
    (cond
     ((not p) (error "wait: timed out"))
     ((not (string=? (car p) m)) (error "wait: bad return packet" p m))
     (else p))))

(define (async fd m)
  (send fd m)
  (wait fd "/done"))

(define (reset fd)
  (send fd (bundle -1
		   (/g_freeAll 0)
		   /clearSched
		   (/g_new 1 0 0))))

(define (with-sc3 f)
  (let* ((fd (open-udp* "127.0.0.1" 57110))
	 (r (f fd)))
    (udp*-close fd)
    r))

)
