;; bytes.ss - (c) rohan drape, 2006

(module
 bytes mzscheme
 (require (only (lib "1.ss" "srfi")
		take))

(define read-u8 read-byte)
(define write-u8 write-byte)
(define peek-u8 peek-byte)

(define (with-output-to-bytes f)
  (let ((p (open-output-bytes)))
    (parameterize
     ((current-output-port p))
     (f)
     (get-output-bytes p))))

(define (with-output-to-u8l f)
  (bytes->list (with-output-to-bytes f)))

(define (with-input-from-u8l l f)
  (parameterize
   ((current-input-port (open-input-bytes (list->bytes l))))
   (f)))

(define (real->u8l n size)
  (bytes->list (real->floating-point-bytes n (/ size 8) #t)))

(define (u8l->real l)
  (floating-point-bytes->real (list->bytes l) #t))

(provide read-u8 peek-u8 write-u8
	 with-input-from-u8l with-output-to-u8l
	 real->u8l u8l->real))
