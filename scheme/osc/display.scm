;; display.scm - (c) rohan drape, 2005-2006

;; Write a text representation of the OSC u8l `l'.  The format is that
;; used throughout the OSC specification.

(define (osc-display l)
  (for-each 
   (lambda (b n)
     (display (format "~a (~a)" (number->string b 16) (integer->char b)))
     (if (= 3 (modulo n 4))
	 (newline)
	 (display #\space)))
   l
   (iota (length l))))
