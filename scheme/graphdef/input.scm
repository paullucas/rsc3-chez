;; input.scm - (c) rohan drape, 2003-2006

;; An <input> represents a UGen input signal in a UGen graph, an
;; 'Input Specification'.  The <integer> ugen is the index of the
;; UGen, the <integer> port is an output port at ugen.

(define-structure input ugen port)

(define (input->u8t i)
  (list (i16->u8v (input-ugen i))
	(i16->u8v (input-port i))))

(define (input*? i)
  (or (number? i)
      (control*? i)
      (ugen? i)
      (proxy? i)
      (mce? i)))
