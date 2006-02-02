;; output.scm - (c) rohan drape, 2003-2006

;; An <output> represents a UGen output signal in a UGen graph.

(define-structure output rate)

(define (output->u8v o)
  (i8->u8v (rate-value (output-rate o))))

(define (make-outputs n r)
  (make-list n (make-output r)))
