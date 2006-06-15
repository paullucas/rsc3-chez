;; bytes.ss - (c) rohan drape, 2006

(module 
 bytes mzscheme
 (require (only (lib "1.ss" "srfi")
		take))

(define read-u8 read-byte)
(define write-u8 write-byte)
(define peek-u8 peek-byte)

(define (with-input-u8l l f)
  (let ((p (open-input-bytes (list->bytes l)))
	(h (current-input-port)))
    (parameterize 
     ((current-input-port p))
     (f))))

(define (real->u8l n size)
  (bytes->list (real->floating-point-bytes n (/ size 8) #t)))

(define (u8l->real l)
  (floating-point-bytes->real (list->bytes l) #t))

(provide read-u8
	 write-u8
	 with-intput-u8l
	 real->u8v
	 u8v->real))
