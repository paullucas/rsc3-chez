;; transport.scm - (c) rohan drape, 2004-2007

(module transport (lib "lang.ss" "r5rs")
(#%require (only "decode.scm"
		 u8l->osc)
	   (only "encode.scm"
		 osc->u8l)
	   (only "../u8/u8l.scm"
		 u32->u8l
		 u8l->u32)
	   (only "../../module/tcp.ss"
		 tcp*?
		 tcp*-send
		 tcp*-read)
	   (only "../../module/udp.ss"
		 udp*?
		 udp*-send
		 udp*-recv)
	   (only (lib "23.ss" "srfi")
		 error))
(#%provide osc-send
	   osc-recv
	   osc-request)

;; 'u' is a <udp*>, 't' is a timeout in seconds.

(define (osc-send u m)
  (cond ((udp*? u)
	 (udp*-send u (osc->u8l m)))
	((tcp*? u)
	 (let* ((b (osc->u8l m))
		(n (length b)))
	   (tcp*-send u (u32->u8l n))
	   (tcp*-send u b)))
	(else
	 (error "osc-send: unknown transport"))))

(define (osc-recv u t)
  (cond ((udp*? u)
	 (let ((b (udp*-recv u t)))
	   (if b (u8l->osc b) #f)))
	((tcp*? u)
	 (let ((b (tcp*-read u t 4)))
	   (if b 
	       (let* ((n (u8l->u32 b))
		      (b* (tcp*-read u t n)))
		 (if b* (u8l->osc b*) #f))
	       #f)))
	(else
	 (error "osc-recv: unknown transport"))))

(define (osc-request u r m t)
  (osc-send u m)
  (let ((p (osc-recv u t)))
    (if (and p (string=? (car p) r)) p #f)))

)
