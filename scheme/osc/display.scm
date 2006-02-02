;; display.scm - (c) rohan drape, 2005-2006

;; Write a text representation of the OSC byte string `s' to
;; `output-port'.  The display format is that used throughout the OSC
;; specification.

(define (osc-display! s output-port)
  (do ((length (u8v-length s))
       (n 0 (+ n 1)))
      ((= n length))
    (let ((i (u8v-ref s n)))
      (display (format "~a (~a)" (number->string i 16) (integer->char i))
	       output-port)
      (if (= 3 (modulo n 4))
	  (newline output-port)
	  (display #\space output-port)))))
