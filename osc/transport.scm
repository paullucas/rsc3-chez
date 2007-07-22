;; transport.scm - (c) rohan drape, 2004-2007

(module transport (lib "lang.ss" "r5rs")
(#%require "../mzscheme/r6rs.ss"
	   (only "decode.scm"
		 u8l->osc)
	   (only "encode.scm"
		 osc->u8l)
	   (only "../u8/u8l.scm"
		 u32->u8l
		 u8l->u32)
	   (only "../mzscheme/udp.ss"
		 udp*?
		 udp*-send
		 udp*-recv))
(#%provide osc-send
	   osc-recv
	   osc-request)

;; 'u' is a <udp*>, 't' is a timeout in seconds.

(define (osc-send u m)
  (cond ((udp*? u)
	 (udp*-send u (osc->u8l m)))
	(else
	 (error 'osc-send "unknown transport"))))

(define (osc-recv u t)
  (cond ((udp*? u)
	 (let ((b (udp*-recv u t)))
	   (if b (u8l->osc b) #f)))
	(else
	 (error 'osc-recv "unknown transport"))))

(define (osc-request u r m t)
  (osc-send u m)
  (let ((p (osc-recv u t)))
    (if (and p (string=? (car p) r)) p #f)))

)
