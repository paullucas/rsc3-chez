;; input.scm - (c) rohan drape, 2003-2005

;; An <input> represents a UGen input signal in a UGen graph, an
;; 'Input Specification'.  The <integer> ugen is the index of the
;; UGen, the <integer> port is an output port at ugen.

(define-structure input ugen port)

(defineH input->u8t (input ugen port)
  (list (i16->u8v ugen) (i16->u8v port)))

(define (input*? i)
  (or (number? i)
      (control*? i)
      (ugen? i)
      (proxy? i)
      (mce? i)))
