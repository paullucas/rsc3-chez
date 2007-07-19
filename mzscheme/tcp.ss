;; tcp.ss - (c) rohan drape, 2004-2007

(module
 tcp mzscheme
 (require (only "../structure/structure.scm"
		define-structure))

 (define-structure tcp* i o h p)

 (define (open-tcp* h p)
   (let-values
    (((i o) (tcp-connect h p)))
    (file-stream-buffer-mode i 'none)
    (file-stream-buffer-mode o 'none)
    (make-tcp* i o h p)))

 (define (tcp*-send u b)
   (let ((o (tcp*-o u)))
     (for-each (lambda (e) (write-byte e o)) b)))

 (define (tcp*-close u)
   (close-input-port (tcp*-i u))
   (close-output-port (tcp*-o u)))

 ;; Read n bytes from u, should wait at most `t' seconds.
 ;; Note: timeout is not implemented.

 (define (tcp*-read u t n)
   (let* ((i (tcp*-i u))
	  (b (make-bytes n))
	  (r (read-bytes! b i)))
     (if (or (eof-object? r) (not (= r n)))
	 #f
	 (bytes->list b))))

 (provide tcp*?
	  open-tcp*
	  tcp*-send
	  tcp*-read
	  tcp*-close))
