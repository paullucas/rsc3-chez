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

(define (int->u8l n size signed?)
  (bytes->list (integer->integer-bytes n size signed? #t)))

(define (u8l->int l size signed?)
  (integer-bytes->integer (list->bytes l) signed? #t))

(define (real->u8l n size)
  (bytes->list (real->floating-point-bytes n size #t)))

(define (u8l->real l size)
  (floating-point-bytes->real (list->bytes (take l size)) #t))

(provide (all-defined)))
