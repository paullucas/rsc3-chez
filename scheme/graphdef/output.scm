;; output.scm - (c) rohan drape, 2003-2005

;; An <output> represents a UGen output signal in a UGen graph.

(define-structure output rate)

(defineH output->u8v (output rate)
  (i8->u8v rate))

(define (make-outputs n r)
  (make-list n (make-output r)))
