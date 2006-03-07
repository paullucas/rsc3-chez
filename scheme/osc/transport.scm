;; transport.scm - (c) rohan drape, 2004-2006

;; 'u' is a <udp*>, 't' is a timeout in seconds.

(define (osc-send u m)
  (udp*-send u (osc->u8v m)))

(define (osc-recv u t)
  (let ((b (udp*-recv u t)))
    (if b (u8v->osc b) #f)))

(define (osc-request u r m t)
  (osc-send u m)
  (let ((p (osc-recv u t)))
    (if (and p (string=? (car p) r)) p #f)))
